
-- Helpers
CREATE OR REPLACE FUNCTION public.current_company_id()
RETURNS bigint LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT id_companhia FROM public.usuarios WHERE uid = auth.uid() AND coalesce(acesso,true) LIMIT 1
$$;
CREATE OR REPLACE FUNCTION public.is_vsb_admin()
RETURNS boolean LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT EXISTS (SELECT 1 FROM public.usuarios WHERE uid = auth.uid() AND vsb_adm = true AND coalesce(acesso,true))
$$;
REVOKE ALL ON FUNCTION public.current_company_id() FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.is_vsb_admin() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.current_company_id() TO authenticated;
GRANT EXECUTE ON FUNCTION public.is_vsb_admin() TO authenticated;

-- Company-scoped tables
DO $$
DECLARE r record;
BEGIN
  FOR r IN SELECT * FROM (VALUES
    ('clientes','ACESSO_GERAL'),('planos','Acesso_Geral'),('anamnese','ALL'),
    ('conta_receber','ALL'),('estoque_evolucao','ALL'),('produtos','all'),
    ('agenda_visual_base','Agendamento'),('planos_Entrada','All'),('evolucao_cliente','Acesso_Geral'),
    ('agendamento','Acesso_Geral'),('item_financeiro','all'),('estoque','all'),
    ('conta_pagar','ALL'),('anamnese_cliente','ALL'),('categoria','all'),
    ('procedimentos','acesso geral'),('agenda_visual','all'),('financeiro','all')
  ) AS t(tbl, pol)
  LOOP
    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', r.pol, r.tbl);
    EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON public.%I TO authenticated', r.tbl);
    EXECUTE format('CREATE POLICY "Company members manage own company data" ON public.%I FOR ALL TO authenticated USING (id_companhia = public.current_company_id() OR public.is_vsb_admin()) WITH CHECK (id_companhia = public.current_company_id() OR public.is_vsb_admin())', r.tbl);
  END LOOP;
END $$;

-- usuarios
DROP POLICY IF EXISTS "ACESSO GERAL" ON public.usuarios;
CREATE POLICY "Users see self and own company" ON public.usuarios FOR SELECT TO authenticated
  USING (uid = auth.uid() OR id_companhia = public.current_company_id() OR public.is_vsb_admin());
CREATE POLICY "Company or admin inserts users" ON public.usuarios FOR INSERT TO authenticated
  WITH CHECK (uid = auth.uid() OR id_companhia = public.current_company_id() OR public.is_vsb_admin());
CREATE POLICY "Company or admin updates users" ON public.usuarios FOR UPDATE TO authenticated
  USING (id_companhia = public.current_company_id() OR public.is_vsb_admin())
  WITH CHECK (id_companhia = public.current_company_id() OR public.is_vsb_admin());
CREATE POLICY "Company or admin deletes users" ON public.usuarios FOR DELETE TO authenticated
  USING (id_companhia = public.current_company_id() OR public.is_vsb_admin());

-- Prevent privilege escalation of vsb_adm by non-admins
CREATE OR REPLACE FUNCTION public.protect_vsb_adm()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  IF auth.uid() IS NULL OR public.is_vsb_admin() THEN RETURN NEW; END IF;
  IF TG_OP = 'INSERT' AND NEW.vsb_adm THEN NEW.vsb_adm := false; END IF;
  IF TG_OP = 'UPDATE' AND NEW.vsb_adm IS DISTINCT FROM OLD.vsb_adm THEN NEW.vsb_adm := OLD.vsb_adm; END IF;
  RETURN NEW;
END $$;
DROP TRIGGER IF EXISTS trg_protect_vsb_adm ON public.usuarios;
CREATE TRIGGER trg_protect_vsb_adm BEFORE INSERT OR UPDATE ON public.usuarios
  FOR EACH ROW EXECUTE FUNCTION public.protect_vsb_adm();

-- companhia
DROP POLICY IF EXISTS "ACESSO_GERAL" ON public.companhia;
CREATE POLICY "Members read own company" ON public.companhia FOR SELECT TO authenticated
  USING (id = public.current_company_id() OR public.is_vsb_admin());
CREATE POLICY "Members update own company" ON public.companhia FOR UPDATE TO authenticated
  USING (id = public.current_company_id() OR public.is_vsb_admin())
  WITH CHECK (id = public.current_company_id() OR public.is_vsb_admin());
CREATE POLICY "Admins create companies" ON public.companhia FOR INSERT TO authenticated WITH CHECK (public.is_vsb_admin());
CREATE POLICY "Admins delete companies" ON public.companhia FOR DELETE TO authenticated USING (public.is_vsb_admin());

-- vsb_cadastr_versao
DROP POLICY IF EXISTS "all" ON public.vsb_cadastr_versao;
CREATE POLICY "Signed-in users read versions" ON public.vsb_cadastr_versao FOR SELECT TO authenticated USING (auth.uid() IS NOT NULL);
CREATE POLICY "Admins manage versions" ON public.vsb_cadastr_versao FOR ALL TO authenticated USING (public.is_vsb_admin()) WITH CHECK (public.is_vsb_admin());

-- controle_execucao (used only by security definer routine)
DROP POLICY IF EXISTS "ALL" ON public.controle_execucao;
CREATE POLICY "Admins manage execution control" ON public.controle_execucao FOR ALL TO authenticated USING (public.is_vsb_admin()) WITH CHECK (public.is_vsb_admin());

-- clientes_n8n (filled by trigger)
DROP POLICY IF EXISTS "ALL" ON public.clientes_n8n;
CREATE POLICY "Admins manage n8n queue" ON public.clientes_n8n FOR ALL TO authenticated USING (public.is_vsb_admin()) WITH CHECK (public.is_vsb_admin());
ALTER FUNCTION public.fn_insert_clientes_n8n() SECURITY DEFINER;

-- Storage: vsbgaleria
DROP POLICY IF EXISTS "Acesso Geral 1ts4s4y_0" ON storage.objects;
DROP POLICY IF EXISTS "Acesso Geral 1ts4s4y_1" ON storage.objects;
DROP POLICY IF EXISTS "Acesso Geral 1ts4s4y_2" ON storage.objects;
DROP POLICY IF EXISTS "Acesso Geral 1ts4s4y_3" ON storage.objects;
CREATE POLICY "vsbgaleria signed-in read" ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'vsbgaleria' AND auth.uid() IS NOT NULL);
CREATE POLICY "vsbgaleria owner upload" ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'vsbgaleria' AND owner_id = (select auth.uid()::text));
CREATE POLICY "vsbgaleria owner update" ON storage.objects FOR UPDATE TO authenticated
  USING (bucket_id = 'vsbgaleria' AND owner_id = (select auth.uid()::text))
  WITH CHECK (bucket_id = 'vsbgaleria' AND owner_id = (select auth.uid()::text));
CREATE POLICY "vsbgaleria owner delete" ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'vsbgaleria' AND owner_id = (select auth.uid()::text));
