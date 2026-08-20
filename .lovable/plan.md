# Plano de Implementação - Controle de Sessões em Novo Agendamento

Este plano detalha a reestruturação do modal de Novo Agendamento para integrar o controle dinâmico de sessões baseado nos planos contratados pelos clientes no Supabase.

## Objetivos
- Consultar planos ativos do cliente ao abrir o modal de agendamento.
- Calcular o saldo de sessões em tempo real (Contratadas - Consumidas).
- Adicionar um dropdown de "Plano Disponível" com o saldo atualizado.
- Garantir a integridade dos dados impedindo agendamentos em planos sem saldo.

## Detalhes Técnicos

### 1. Levantamento de Dados (Supabase)
- **Tabela `planos`**:
  - `id`: Identificador único do plano.
  - `id_cliente`: FK para o cliente.
  - `sessoes`: Quantidade total contratada.
  - `nome_plano`: Descrição para exibição.
  - `id_procedimento`: FK para o procedimento vinculado (se houver).
- **Tabela `agendamento`**:
  - `id_plano`: FK para o plano utilizado na sessão.
  - `status_procedimento`: Utilizado para contar sessões 'Concluído'.
  - `data_inicio`: Referência para a data do atendimento.

### 2. Lógica de Negócio no Frontend (`Index.tsx`)
- **Novo Estado**:
  - `availablePlans`: Lista de planos com saldo > 0 para o cliente selecionado.
  - `selectedPlanId`: Armazena o plano escolhido para o agendamento.
- **Função de Cálculo (`fetchAvailablePlans`)**:
  1. Busca todos os planos do cliente via `id_cliente` e `id_companhia`.
  2. Para cada plano, conta quantos registros existem na tabela `agendamento` com `id_plano` e `status_procedimento = 'Concluído'`.
  3. Calcula `saldo = sessoes_contratadas - sessões_concluídas`.
  4. Filtra apenas planos onde `saldo > 0`.
- **Validação no Salvamento**:
  - Antes do `insert` no agendamento, realizar uma nova consulta rápida ao Supabase para garantir que o saldo ainda é positivo (evita race conditions).

### 3. Interface do Usuário (UI)
- Inserção do dropdown de planos entre a seleção do cliente e o procedimento.
- Rótulo dinâmico: `{nome_plano} — {saldo} sessões disponíveis`.
- Feedback visual caso o cliente não possua planos ativos, permitindo agendamento avulso conforme fluxo legado.

## Arquivos Afetados
- `src/pages/Index.tsx`: Implementação da lógica de busca, cálculo, validação e UI no modal.
- `mem://features/appointment-plan-logic`: Registro da regra de negócio na memória do projeto.

## Próximos Passos
1. Implementar a função `fetchAvailablePlans` dentro do `handleSelectClient`.
2. Adicionar o componente de `Select` para os planos no modal de agendamento.
3. Atualizar a função `handleSaveAppointment` para incluir o `id_plano` e realizar a validação final.
