// TypeScript model converted from FlutterFlow Editar_Plano_Entrada
// Source: extracted_code/components/Editar_Plano_Entrada/Editar_Plano_Entrada_model.dart

export interface EditarPlanoEntradaModel {
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

export const createEditarPlanoEntradaModel = (): EditarPlanoEntradaModel => ({} as EditarPlanoEntradaModel);
