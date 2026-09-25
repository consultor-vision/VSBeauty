DROP POLICY IF EXISTS "vsbgaleria signed-in read" ON storage.objects;
CREATE POLICY "vsbgaleria owner read" ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'vsbgaleria' AND owner_id = (select auth.uid()::text));

DROP POLICY IF EXISTS "Signed-in users read versions" ON public.vsb_cadastr_versao;
CREATE POLICY "Linked users read versions" ON public.vsb_cadastr_versao FOR SELECT TO authenticated
  USING (public.current_company_id() IS NOT NULL OR public.is_vsb_admin());