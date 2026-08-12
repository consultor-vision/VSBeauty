-- Fix SECURITY DEFINER permissions
REVOKE ALL ON FUNCTION public.fn_recalc_plano(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.fn_recalc_plano(bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.notify_n8n_agendamento() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.notify_cadastro_n8n() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.notify_n8n_nova_versao() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.salvar_anamnese_cliente(bigint, bigint, text[], text[]) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.salvar_ou_atualizar_anamnese_cliente(bigint, bigint, text[], text[]) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.verificar_e_atualizar_contas() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.fn_sync_plano_por_agendamento() FROM PUBLIC;

GRANT EXECUTE ON FUNCTION public.fn_recalc_plano(integer) TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.fn_recalc_plano(bigint) TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.notify_n8n_agendamento() TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.notify_cadastro_n8n() TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.notify_n8n_nova_versao() TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.salvar_anamnese_cliente(bigint, bigint, text[], text[]) TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.salvar_ou_atualizar_anamnese_cliente(bigint, bigint, text[], text[]) TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.verificar_e_atualizar_contas() TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.fn_sync_plano_por_agendamento() TO authenticated, service_role;
