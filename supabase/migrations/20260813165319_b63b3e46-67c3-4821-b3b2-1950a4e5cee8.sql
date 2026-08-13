-- REVOKE EXECUTE from PUBLIC for SECURITY DEFINER functions in public schema
-- This prevents users from calling them directly unless they have explicit permission
REVOKE EXECUTE ON FUNCTION public.notify_n8n_agendamento() FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.notify_cadastro_n8n() FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.notify_n8n_nova_versao() FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.salvar_anamnese_cliente(bigint, bigint, text[], text[]) FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.salvar_ou_atualizar_anamnese_cliente(bigint, bigint, text[], text[]) FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.verificar_e_atualizar_contas() FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.fn_sync_plano_por_agendamento() FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.fn_recalc_plano(integer) FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.fn_recalc_plano(bigint) FROM PUBLIC;

-- GRANT EXECUTE specifically to authenticated users (or service_role if needed)
-- Adjust based on who actually needs to call these from the frontend
GRANT EXECUTE ON FUNCTION public.salvar_anamnese_cliente(bigint, bigint, text[], text[]) TO authenticated;
GRANT EXECUTE ON FUNCTION public.salvar_ou_atualizar_anamnese_cliente(bigint, bigint, text[], text[]) TO authenticated;
GRANT EXECUTE ON FUNCTION public.fn_recalc_plano(integer) TO authenticated;
GRANT EXECUTE ON FUNCTION public.fn_recalc_plano(bigint) TO authenticated;

-- For background/notification functions, usually only service_role or triggers need them
GRANT EXECUTE ON FUNCTION public.notify_n8n_agendamento() TO service_role;
GRANT EXECUTE ON FUNCTION public.notify_cadastro_n8n() TO service_role;
GRANT EXECUTE ON FUNCTION public.notify_n8n_nova_versao() TO service_role;
GRANT EXECUTE ON FUNCTION public.verificar_e_atualizar_contas() TO service_role;
GRANT EXECUTE ON FUNCTION public.fn_sync_plano_por_agendamento() TO service_role;
