# Plan: Company-Wide Data Isolation

Ensure all system modules (Agenda, Cadastro, Evolução, Gestão, Analytics) exclusively display and manage data belonging to the logged-in user's company (`id_companhia`).

## Technical Details
- Use `user.id_companhia` from `useAuth` hook as the primary filter for all Supabase queries.
- Replace mock data in `Gestao.tsx` and `Analytics.tsx` with live database calls.
- Standardize CRUD operations to include `id_companhia` in all inserts and updates.

## Proposed Changes

### 1. Data Service Layer / Hooks
- Audit `src/lib/auth-service.ts` to ensure session integrity.
- Verify `src/hooks/use-auth.tsx` provides reliable company context.

### 2. Module: Agenda (src/pages/Index.tsx)
- Ensure all status updates in `executeStatusUpdate` include `eq('id_companhia', user.id_companhia)`.
- Verify birthday list filtering by company.

### 3. Module: Cadastro (src/pages/Cadastro.tsx)
- Add missing `id_companhia` filters to `fetchClientPlans` and anamnese checks.
- Ensure new client, plan, and anamnese records are created with the correct `id_companhia`.

### 4. Module: Evolução (src/pages/Evolucao.tsx)
- Audit all queries to ensure no leaks across companies.
- Add `id_companhia` to `estoque_evolucao` queries.

### 5. Module: Gestão (src/pages/Gestao.tsx)
- Implement real fetching for:
  - **Colaboradores**: Table `usuarios`.
  - **Procedimentos**: Table `procedimentos`.
  - **Anamnese**: Table `anamnese`.
  - **Estoque**: Tables `estoque` and `produtos`.
  - **Financeiro**: Tables `conta_pagar` and `conta_receber`.
- All queries must use `.eq('id_companhia', user.id_companhia)`.

### 6. Module: Analytics (src/pages/Analytics.tsx)
- Implement real data fetching using analytics views:
  - `vw_analytics_financeiro_mensal`
  - `vw_analytics_total_clientes`
  - `vw_analytics_clientes_genero`
  - `vw_analytics_procedimentos_top`
  - `vw_analytics_atendimentos_resumo`
  - `vw_analytics_periodo_dia`
  - `vw_analytics_dia_semana`
- Filter all views by `id_companhia` (if present in the view) or join with source tables to enforce isolation.

## Verification Plan
- Sign in with users from different companies.
- Verify that no data from Company A is visible to Company B.
- Perform CRUD operations and confirm `id_companhia` is correctly persisted in the database.
