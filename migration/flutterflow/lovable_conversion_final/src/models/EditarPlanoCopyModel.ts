// TypeScript model converted from FlutterFlow Editar_PlanoCopy
// Source: extracted_code/components/Editar_PlanoCopy/Editar_PlanoCopy_model.dart

export interface EditarPlanoCopyModel {
  idProcedimento: number | null;
  procedimentoValue: string | null;
  procedimentoValueController: unknown | null;
  quantSessaoFocusNode: unknown | null;
  quantSessaoTextController: unknown | null;
  quantSessaoMask: unknown;
  valorProcedimentoFocusNode: unknown | null;
  valorProcedimentoTextController: unknown | null;
  formaPagamentoValue: string | null;
  formaPagamentoValueController: unknown | null;
  parcelasFocusNode: unknown | null;
  parcelasTextController: unknown | null;
  parcelasMask: unknown;
  statusprocedimentoValue: string | null;
  statusprocedimentoValueController: unknown | null;
  statusFinanceiroValue: string | null;
  statusFinanceiroValueController: unknown | null;
  selecionarProcedimento: unknown[] | null;
}

export const createEditarPlanoCopyModel = (): EditarPlanoCopyModel => ({} as EditarPlanoCopyModel);
