CREATE TABLE public.whatsapp_envios (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo text NOT NULL CHECK (tipo IN ('cadastro','agendamento_novo','agendamento_remarcado','agendamento_cancelado')),
  chave text NOT NULL UNIQUE,
  id_cliente bigint,
  id_agendamento bigint,
  id_companhia bigint,
  telefone text,
  status text NOT NULL DEFAULT 'pendente' CHECK (status IN ('pendente','enviado','erro','ignorado')),
  resposta jsonb,
  erro text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX idx_whatsapp_envios_companhia ON public.whatsapp_envios(id_companhia);
CREATE INDEX idx_whatsapp_envios_created ON public.whatsapp_envios(created_at DESC);
GRANT SELECT ON public.whatsapp_envios TO authenticated;
GRANT ALL ON public.whatsapp_envios TO service_role;
ALTER TABLE public.whatsapp_envios ENABLE ROW LEVEL SECURITY;
CREATE POLICY "VSB admins read whatsapp log" ON public.whatsapp_envios
  FOR SELECT TO authenticated USING (public.is_vsb_admin());

CREATE OR REPLACE FUNCTION public.whatsapp_envios_touch() RETURNS trigger
LANGUAGE plpgsql SET search_path = public AS $$ BEGIN NEW.updated_at = now(); RETURN NEW; END; $$;
CREATE TRIGGER trg_whatsapp_envios_touch BEFORE UPDATE ON public.whatsapp_envios
  FOR EACH ROW EXECUTE FUNCTION public.whatsapp_envios_touch();

-- Segredo compartilhado entre gatilho e função de envio (gerado no banco)
SELECT vault.create_secret(encode(extensions.gen_random_bytes(32),'hex'), 'whatsapp_webhook_secret', 'Autentica gatilhos -> whatsapp-notify')
WHERE NOT EXISTS (SELECT 1 FROM vault.secrets WHERE name = 'whatsapp_webhook_secret');

CREATE OR REPLACE FUNCTION public.get_whatsapp_webhook_secret() RETURNS text
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public, vault AS $$
  SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'whatsapp_webhook_secret' LIMIT 1
$$;
REVOKE ALL ON FUNCTION public.get_whatsapp_webhook_secret() FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.get_whatsapp_webhook_secret() TO service_role;