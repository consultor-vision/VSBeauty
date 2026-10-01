CREATE OR REPLACE FUNCTION public.whatsapp_dispatch(p_tipo text, p_id bigint) RETURNS void
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public, pg_temp AS $$
DECLARE v_secret text;
BEGIN
  SELECT decrypted_secret INTO v_secret FROM vault.decrypted_secrets WHERE name = 'whatsapp_webhook_secret' LIMIT 1;
  PERFORM net.http_post(
    url := 'https://ijcwsuibamqdlksgujlp.supabase.co/functions/v1/whatsapp-notify',
    body := jsonb_build_object('tipo', p_tipo, 'id', p_id),
    headers := jsonb_build_object('Content-Type','application/json','x-webhook-secret', v_secret)
  );
EXCEPTION WHEN others THEN
  RAISE NOTICE 'Falha ao agendar aviso WhatsApp: %', SQLERRM;
END; $$;

CREATE OR REPLACE FUNCTION public.trg_whatsapp_clientes() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public, pg_temp AS $$
BEGIN PERFORM public.whatsapp_dispatch('cadastro', NEW.id); RETURN NEW; END; $$;

CREATE OR REPLACE FUNCTION public.trg_whatsapp_agendamento() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public, pg_temp AS $$
DECLARE v_cancel_new boolean := lower(coalesce(NEW.status_procedimento,'')) = 'cancelado';
BEGIN
  IF TG_OP = 'INSERT' THEN
    IF NOT v_cancel_new THEN PERFORM public.whatsapp_dispatch('agendamento_novo', NEW.id); END IF;
  ELSIF v_cancel_new AND lower(coalesce(OLD.status_procedimento,'')) <> 'cancelado' THEN
    PERFORM public.whatsapp_dispatch('agendamento_cancelado', NEW.id);
  ELSIF NOT v_cancel_new AND (NEW.data_inicio IS DISTINCT FROM OLD.data_inicio
        OR NEW.hora_inicio IS DISTINCT FROM OLD.hora_inicio
        OR NEW.hora_fim IS DISTINCT FROM OLD.hora_fim) THEN
    PERFORM public.whatsapp_dispatch('agendamento_remarcado', NEW.id);
  END IF;
  RETURN NEW;
END; $$;

REVOKE ALL ON FUNCTION public.whatsapp_dispatch(text, bigint) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.trg_whatsapp_clientes() FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.trg_whatsapp_agendamento() FROM PUBLIC, anon, authenticated;

CREATE TRIGGER trg_whatsapp_clientes AFTER INSERT ON public.clientes
  FOR EACH ROW EXECUTE FUNCTION public.trg_whatsapp_clientes();
CREATE TRIGGER trg_whatsapp_agendamento AFTER INSERT OR UPDATE ON public.agendamento
  FOR EACH ROW EXECUTE FUNCTION public.trg_whatsapp_agendamento();

-- Desliga N8N (cadastro e agendamento)
DROP TRIGGER IF EXISTS notify_n8n_agendamentos_trigger ON public.agenda_visual;
DROP TRIGGER IF EXISTS notify_n8n_trigger ON public.clientes_n8n;
DROP TRIGGER IF EXISTS trg_clientes_to_n8n ON public.clientes;