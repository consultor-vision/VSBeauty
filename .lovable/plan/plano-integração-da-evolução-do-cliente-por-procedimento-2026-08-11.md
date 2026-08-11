# Plano: Integração da Evolução do Cliente por Procedimento

O objetivo é buscar os dados da tabela `evolucao_cliente` do Supabase quando um procedimento específico for selecionado, replicando o comportamento do sistema anterior para exibir observações e fotos (antes/depois).

## Detalhes Técnicos

- **Componente:** `src/pages/Evolucao.tsx`
- **Tabelas Envolvidas:**
    - `planos`: Para listar os procedimentos (já implementado).
    - `agendamento`: Para buscar as sessões confirmadas do plano selecionado.
    - `evolucao_cliente`: Para buscar os dados de evolução vinculados a cada agendamento (sessão).
- **Lógica de Busca:**
    - Ao selecionar um procedimento (plano), a função `fetchSessions` já realiza uma busca no Supabase incluindo o `join` com `evolucao_cliente`.
    - Vou refinar essa consulta para garantir que todos os campos necessários (`observacao`, `antes`, `depois`) sejam carregados corretamente.
    - Garantir que a exibição da observação e fotos mude dinamicamente ao selecionar diferentes sessões na tabela "Relatório de Planos".
- **Interface:**
    - Manter a estrutura de 100vh com painéis de vidro (`glass-panel`).
    - Exibir a lista de sessões com data, nome do plano e profissional.
    - Atualizar o painel de Observação e o painel de Fotos (Antes/Depois) com base na sessão selecionada.

## Etapas de Implementação

1. **Refinar Consulta `fetchSessions`:** Garantir que o `select` traga os dados da `evolucao_cliente` e que a tipagem seja respeitada.
2. **Sincronização de Estado:** Garantir que ao clicar em uma linha da tabela de sessões, os estados `selectedSessionIdx`, `observacao` e os dados da imagem sejam atualizados.
3. **Validação Visual:** Verificar se as fotos e observações estão sendo renderizadas conforme os dados do Supabase.
4. **Tratamento de Erros:** Exibir mensagens adequadas caso a busca falhe ou não existam dados.
