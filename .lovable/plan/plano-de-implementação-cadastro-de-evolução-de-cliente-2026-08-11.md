# Plano de Implementação - Cadastro de Evolução de Cliente

Implementação da funcionalidade de Evolução de Cliente, permitindo o registro de sessões, fotos (antes/depois) e observações, integrada com o Supabase e filtrada pela companhia do usuário logado.

## User Review Required

> [!IMPORTANT]
> A implementação utilizará as tabelas `clientes` e `agendamento` (ou similar para sessões) do Supabase. A estrutura de "Evolução" (fotos e observações por sessão) será salva em tabelas relacionadas que serão validadas durante a execução.

- O formulário será aberto via botão "Evolução" no menu inferior.
- A listagem de clientes será filtrada por `id_companhia`.

## Proposed Changes

### 1. Integração de Dados (Supabase)
- **Sub-agente:** `🗄️ Supabase Engineer`
- Substituir `mockClients` em `Evolucao.tsx` por busca real na tabela `clientes` filtrando por `id_companhia` do usuário logado.
- Buscar planos e sessões vinculadas ao cliente selecionado.

### 2. Interface de Evolução
- **Sub-agente:** `🎨 UI Architect`
- Ajustar o modal "Cadastro Geral" dentro de `Evolucao.tsx` para garantir que as fotos dos clientes sejam exibidas conforme o padrão visual solicitado (terceira imagem).
- Implementar a lógica de seleção de cliente para preencher os campos de cabeçalho (Nome, Data de Nascimento, CPF).
- Refinar a visualização de "Antes" e "Depois" para upload/exibição de imagens.

### 3. Lógica de Navegação e Estado
- **Sub-agente:** `UI Architect`
- Garantir que ao clicar em "Evolução" o modal de busca de clientes abra automaticamente se nenhum cliente estiver selecionado.
- Adicionar feedbacks de carregamento e estados vazios.

## Technical Details

- **Filtro de Companhia:** Utilizar o `user.id_companhia` obtido através do hook `useAuth`.
- **Ordenação:** Clientes exibidos em ordem alfabética.
- **Componentes:** Uso de `Table`, `Select` e `Input` do shadcn/ui.
- **Persistência:** As evoluções serão salvas/atualizadas no Supabase (verificar necessidade de tabela `evolucao_cliente` ou similar).

## Operação Multi-Agente

1.  **Analise de Escopo:** Cadastro de evolução exige leitura de clientes, filtragem por empresa e UI de formulário.
2.  **Execução:**
    - `UI Architect` ajusta `Evolucao.tsx`.
    - `Supabase Engineer` implementa o fetching de dados reais.
    - `Code Auditor` valida a segurança (RLS/Filtros).
