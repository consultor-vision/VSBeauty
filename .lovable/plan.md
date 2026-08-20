# Plano de Implementação - Carregamento de Profissionais da Companhia

Este plano descreve a alteração no módulo de Agendamento para que o seletor de profissionais apresente todos os usuários vinculados à mesma companhia do usuário logado, utilizando os dados reais do Supabase.

## Alterações Técnicas

### 🎨 UI Architect
- Nenhuma alteração visual estrutural é necessária, pois o componente de seletor já existe.
- A experiência do usuário será mantida, apenas os dados serão dinâmicos.

### 🗄️ Supabase Engineer
- Utilizar a tabela `usuarios` para buscar os profissionais da companhia.
- Filtro obrigatório por `id_companhia`.

### 🔍 Code Auditor
- Garantir que a busca seja realizada de forma eficiente e apenas uma vez ou quando a companhia mudar.
- Validar se o mapeamento dos dados da tabela `usuarios` (campo `nome`) está correto para o estado do componente.

## Detalhes da Implementação

1. **Busca de Dados**: Adicionar uma chamada ao Supabase no `useEffect` de carregamento de dados (ou criar um específico) para buscar todos os registros da tabela `usuarios` onde `id_companhia` seja igual ao da sessão atual.
2. **Atualização do Estado**: Armazenar a lista de nomes dos profissionais em um novo estado ou atualizar o seletor existente para utilizar esses dados.
3. **Mapeamento no Modal**: No modal de "Novo Agendamento", o seletor "Escolha o Profissional" consumirá esta lista dinâmica em vez da lista estática derivada dos agendamentos passados.

---

### 📊 Relatório de Planejamento

**Sub-agentes ativados:**
- 🎨 **UI Architect** — ➖ Não necessário
- 🗄️ **Supabase Engineer** — ✅ Executado
- 🔍 **Code Auditor** — ✅ Executado
- 🧪 **Testing Agent** — ➖ Não necessário
- 📈 **SEO Optimizer** — ➖ Não necessário
- 🚀 **Deploy Ops** — ➖ Não necessário
- 🔌 **API Integrator** — ➖ Não necessário

**Resumo:** Implementação da lógica de carregamento dinâmico de profissionais da tabela `usuarios` filtrados por companhia para o modal de agendamento.
