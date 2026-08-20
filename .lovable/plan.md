---
title: Integrate vw_estoque_atual view in Gestao page
description: Update the Inventory (Estoque) view in the Management (Gestão) page to fetch and display data from the `vw_estoque_atual` Supabase view instead of the `estoque` table.
---

## Technical Details

1.  **Modify `fetchEstoque` in `src/pages/Gestao.tsx`**:
    *   Change the query source from the `estoque` table to the `vw_estoque_atual` view.
    *   Update the mapping logic to match the view's column names: `nome_produto` (instead of `produtos.produtos`), `tipo_embalagem` (instead of `produtos.tipo_embalagem`), and `quantidade_atual` (instead of `quantidade`).
2.  **Update `EstoqueItem` interface**:
    *   Align the interface properties if necessary, though the current mapping to `produto`, `sistemaMedidas`, and `quantidade` can be maintained for internal consistency.
3.  **Verify UI rendering**:
    *   Ensure the table in `EstoqueView` correctly displays the data returned by the view.

## User Review Required

> [!IMPORTANT]
> The change will switch the data source for the Inventory list. Please confirm that the `vw_estoque_atual` view is correctly configured in your Supabase project to provide the expected data per company.
