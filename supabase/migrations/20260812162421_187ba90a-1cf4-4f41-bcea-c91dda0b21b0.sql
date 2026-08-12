-- Final fix for function permissions to remove 'anon' access
REVOKE EXECUTE ON FUNCTION public.fn_recalc_plano(integer) FROM anon;
REVOKE EXECUTE ON FUNCTION public.fn_recalc_plano(bigint) FROM anon;
REVOKE EXECUTE ON FUNCTION public.notify_n8n_agendamento() FROM anon;
REVOKE EXECUTE ON FUNCTION public.notify_cadastro_n8n() FROM anon;
REVOKE EXECUTE ON FUNCTION public.notify_n8n_nova_versao() FROM anon;
REVOKE EXECUTE ON FUNCTION public.salvar_anamnese_cliente(bigint, bigint, text[], text[]) FROM anon;
REVOKE EXECUTE ON FUNCTION public.salvar_ou_atualizar_anamnese_cliente(bigint, bigint, text[], text[]) FROM anon;
REVOKE EXECUTE ON FUNCTION public.verificar_e_atualizar_contas() FROM anon;
REVOKE EXECUTE ON FUNCTION public.fn_sync_plano_por_agendamento() FROM anon;
