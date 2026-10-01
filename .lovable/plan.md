# Avisos por WhatsApp com uazapi (substituindo N8N + Evolution)

## Objetivo
O próprio sistema envia os avisos pelo WhatsApp, usando uma instância específica da uazapi. Isso substitui o N8N e a Evolution API. Haverá três avisos:
1. **Cadastro concluído**: mesmo texto usado hoje.
2. **Novo agendamento**
3. **Agendamento remarcado ou cancelado**

Quando a nova função estiver validada, os disparos para o N8N serão desligados.

## Como é hoje (confirmado no banco)
- Cadastro: cliente novo → gatilho `trg_clientes_to_n8n` grava em `clientes_n8n` → gatilho `notify_n8n_trigger` chama o webhook do N8N.
- Agendamento: inserção em `agenda_visual` → gatilho `notify_n8n_agendamentos_trigger` chama outro webhook do N8N.
- Também existe `notify_n8n_nova_versao` em `vsb_cadastr_versao`. Ele **não entra** neste plano e fica como está.

## Fluxo novo
```text
clientes (novo)            ─┐
agendamento (novo/alterado) ─┼─> gatilho no banco ─> função "whatsapp-notify" ─> uazapi POST /send/text
                            ─┘                        (monta a mensagem, registra o envio)
```
- A função busca no banco os dados atuais do cliente, da companhia, do procedimento e do profissional. Assim, ninguém de fora consegue mandar texto pronto para ela.
- Os telefones são normalizados para o formato `55DDDNÚMERO`, só com dígitos. Sem telefone válido, nada é enviado e o motivo fica registrado.
- O envio não é repetido automaticamente, como a uazapi recomenda: depois de um tempo esgotado, não dá para saber se a mensagem saiu. Falhas ficam registradas para análise.

## Mensagens (no mesmo padrão)
**Cadastro concluído:** exatamente o texto atual, com nome, e-mail, telefone, companhia e contato.

**Novo agendamento:**
```text
Olá, {nome_cliente}

Seu agendamento foi confirmado!

📅 Data: {dd/MM/yyyy}
⏰ Horário: {HH:mm} às {HH:mm}
💆 Procedimento: {nome_procedimento}
👩‍⚕️ Profissional: {nome_profissional}

Caso precise alterar ou tenha qualquer dúvida, entre em contato diretamente com a clínica responsável pelo atendimento.

🏢 Companhia: {nome_companhia}
☎️ Contato: {telefone_companhia}

Atenciosamente,

VISION SMART BEAUTY – Tecnologia que embeleza a sua vida.
```
**Remarcado:** mesmo formato, com o título "Seu agendamento foi remarcado!" e a nova data e horário.

**Cancelado:** título "Seu agendamento foi cancelado.", data e horário cancelados e a orientação para falar com a clínica.

## Quando cada aviso sai
- **Novo:** um agendamento é criado.
- **Remarcado:** a data, o horário de início ou o horário de fim mudam.
- **Cancelado:** o status passa a ser "Cancelado". O valor exato será conferido nos dados de `status_procedimento` antes de criar a regra.
- Mudanças em outros campos, como confirmação ou profissional, não disparam aviso.

## Etapas
1. **Credenciais:** você informa a Server URL e o token da instância da uazapi. Eles ficam guardados como segredos seguros e nunca aparecem no app.
2. **Registro de envios:** criar a tabela `whatsapp_envios` (tipo, ids, telefone, status, resposta e erro). Ela evita envios duplicados e serve de histórico. Só administradores VSB podem ler. **É uma tabela nova e precisa da sua autorização.**
3. **Função `whatsapp-notify`:** valida a chamada, monta a mensagem, envia pela uazapi e registra o resultado.
4. **Gatilhos novos no banco:** um em `clientes` (cadastro) e outro em `agendamento` (novo, remarcado ou cancelado). Eles chamam a função de forma assíncrona e não travam o salvamento.
5. **Teste:** enviar para um número de teste seu nos três tipos de aviso.
6. **Desligar o N8N:** remover os gatilhos `notify_n8n_agendamentos_trigger`, `notify_n8n_trigger` e `trg_clientes_to_n8n`. A tabela `clientes_n8n` e seus dados ficam guardados, sem uso.

## Detalhes técnicos
- Chamada à uazapi: `POST {UAZAPI_URL}/send/text`, header `token: {UAZAPI_INSTANCE_TOKEN}`, corpo `{ number, text }`. Antes do teste, consultar `/instance/status`.
- Segredos: `UAZAPI_URL` e `UAZAPI_INSTANCE_TOKEN`, pedidos ao usuário. `WHATSAPP_WEBHOOK_SECRET` é gerado automaticamente e usado pelo gatilho no cabeçalho para provar que a chamada vem do banco. Por ser um Supabase externo, ele fica no Vault e é lido pela função do gatilho; nada vai no código.
- Gatilhos: `pg_net` com `net.http_post` e corpo mínimo `{ tipo, id }`, sem dados pessoais no corpo. Funções `SECURITY DEFINER` com `search_path` fixo e EXECUTE revogado de anon e authenticated.
- A função valida o segredo e o corpo com Zod, lê os dados com a service role e grava em `whatsapp_envios` com uma chave única (tipo, id do registro e versão de data e horário), para não enviar a mesma mensagem duas vezes.
- Em `429`, respeitar `Retry-After` só registrando o erro, sem novo envio automático.
- Função `whatsapp-notify` com `verify_jwt = false` e a validação feita pelo segredo.
- Fuso: datas e horas formatadas em America/Sao_Paulo.

## Fora do escopo
- Lembrete antes do horário.
- Um número por clínica.
- Aviso de nova versão.
- Receber respostas dos clientes (webhook de entrada).
