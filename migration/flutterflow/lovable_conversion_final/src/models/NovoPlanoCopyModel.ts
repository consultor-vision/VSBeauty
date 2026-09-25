// TypeScript model converted from FlutterFlow Novo_PlanoCopy
// Source: extracted_code/components/Novo_PlanoCopy/Novo_PlanoCopy_model.dart

export interface NovoPlanoCopyModel {
  idprocedimento: number | null;
  idPlano: number | null;
  pvValorProcedimento: number | null;
  pvQtdSessoes: number | null;
  valorTotal: number | null;
  procedimentoValue: string | null;
  procedimentoValueController: unknown | null;
  outProcedimento: unknown[] | null;
  quantSessaoFocusNode: unknown | null;
  quantSessaoTextController: unknown | null;
  quantSessaoMask: unknown;
  valorProcedimentoFocusNode: unknown | null;
  valorProcedimentoTextController: unknown | null;
  valorTotalFocusNode: unknown | null;
  valorTotalTextController: unknown | null;
  formaPagamentoValue: string | null;
  formaPagamentoValueController: unknown | null;
  parcelasFocusNode: unknown | null;
  parcelasTextController: unknown | null;
  parcelasMask: unknown;
  valorEntradaFocusNode: unknown | null;
  valorEntradaTextController: unknown | null;
  sttProcedimentoFocusNode: unknown | null;
  sttProcedimentoTextController: unknown | null;
  sttProcedimentoMask: unknown;
  sttFinanceiroValue: string | null;
  sttFinanceiroValueController: unknown | null;
  selecionarProcedimento: unknown[] | null;
}

export const createNovoPlanoCopyModel = (): NovoPlanoCopyModel => ({} as NovoPlanoCopyModel);
