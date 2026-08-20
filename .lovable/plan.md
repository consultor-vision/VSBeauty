# Plano de Implementação: Saída de Estoque

Implementar a lógica de saída de estoque no sistema de gestão, permitindo que os usuários registrem a utilização de produtos com persistência no Supabase.

## Ações Propostas

### UI Architect 🎨
- Adicionar funcionalidade ao modal **Editar Estoque** (`showEditarEstoque`) em `src/pages/Gestao.tsx` para permitir a entrada da "Quantidade Utilizada".
- Garantir que o campo de produto e sistema de medidas permaneçam consistentes com o item selecionado.

### Supabase Engineer 🗄️
- Implementar a função de salvamento no modal de edição.
- Ao clicar em "Salvar" no modal de edição, inserir um novo registro na tabela `estoque` com:
  - `id_companhia` do usuário logado.
  - `id_produto` correspondente ao item editado.
  - `quantidade` informada no campo "Quantidade Utilizada".
  - `tipo_movimentacao` definido como `'saida'`.
- Atualizar a interface chamando `fetchEstoque` após o sucesso.

### Code Auditor 🔍
- Validar se a quantidade utilizada é um número positivo e se não excede (opcionalmente) o estoque atual, embora o sistema permita fluxos flexíveis.
- Garantir o uso correto do `id_companhia` para isolamento de dados.

## Detalhes Técnicos
- Arquivo: `src/pages/Gestao.tsx`
- Tabela: `estoque` (Supabase)
- Colunas: `id_companhia`, `id_produto`, `quantidade`, `tipo_movimentacao` ('saida')

## Próximos Passos
1. Atualizar o estado do formulário de edição para capturar a quantidade utilizada.
2. Implementar o handler de clique para o botão "Salvar" no modal de edição de estoque.
3. Notificar o usuário via Toast sobre o sucesso da operação.
