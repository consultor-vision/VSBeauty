# Plano de Implementação - Prontuário Completo de Evolução do Cliente

Implementação de um sistema de prontuário detalhado na tela de Evolução, integrando dados reais do Supabase para planos, sessões, observações e produtos.

## Mudanças Físicas

### Frontend

- **src/pages/Evolucao.tsx**
    - Refatorar a lógica de estados para gerenciar `selectedClient`, `selectedPlan`, `selectedSession` de forma hierárquica.
    - Atualizar `fetchClientPlans` para buscar da tabela `planos` com filtro por `id_cliente` e `id_companhia`.
    - Atualizar `fetchSessions` para buscar da tabela `agendamento` vinculada ao plano.
    - Implementar `fetchSessionDetails` para carregar dados de `evolucao_cliente` e `estoque_evolucao` (produtos) com base no ID da sessão selecionada.
    - Reestruturar o layout em duas colunas: 
        - Esquerda: Relatório de Planos (Tabela), Bloco de Observações, Bloco de Produtos.
        - Direita: Área de visualização de mídia (Evolução) com fotos Antes/Depois.
    - Adicionar lógica de "Trocar Cliente" que reseta todos os sub-estados.
    - Implementar botões "Editar Sessão" (abre modal de edição) e "Acessar Sessão" (carrega dados na área de evolução).
    - Garantir tratamento de estados de loading e "sem dados" conforme especificações.

## Detalhes Técnicos

- **Hierarquia de Dados:** Cliente -> Plano (`planos`) -> Sessão (`agendamento`) -> Evolução (`evolucao_cliente`) + Produtos (`estoque_evolucao`).
- **Relacionamentos:**
    - `planos.id_cliente` -> `clientes.id`
    - `agendamento.id_plano` -> `planos.id`
    - `evolucao_cliente.id_agendamento` -> `agendamento.id`
    - `estoque_evolucao.id_agendamento` -> `agendamento.id`
- **Segurança:** Filtro obrigatório por `id_companhia` em todas as queries.
- **UI/UX:** Manter estética Dark/Gold do Vision Smart Beauty, responsividade mobile-first (empilhamento de colunas).
- **Campos de Produto:** Buscar de `estoque_evolucao` fazendo join com `produtos` para obter o nome e sistema de medidas.

## Próximos Passos

1. Validar nomes de colunas exatos no `types.ts` (ex: `valor_procediemtno`).
2. Implementar as funções de fetch encadeadas.
3. Atualizar o JSX para refletir a nova estrutura de colunas e blocos.
