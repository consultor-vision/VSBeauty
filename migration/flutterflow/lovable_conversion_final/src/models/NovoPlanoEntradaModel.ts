// TypeScript model converted from FlutterFlow Novo_Plano_Entrada
// Source: extracted_code/components/Novo_Plano_Entrada/Novo_Plano_Entrada_model.dart

export interface NovoPlanoEntradaModel {
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
  valorEntradaFocusNode: unknown | null;
  valorEntradaTextController: unknown | null;
  valorTotalFocusNode: unknown | null;
  valorTotalTextController: unknown | null;
  formaPagamentoValue: string | null;
  formaPagamentoValueController: unknown | null;
  parcelasFocusNode: unknown | null;
  parcelasTextController: unknown | null;
  parcelasMask: unknown;
  sttFinanceiroValue: string | null;
  sttFinanceiroValueController: unknown | null;
  selecionarProcedimento: unknown[] | null;
}

export const createNovoPlanoEntradaModel = (): NovoPlanoEntradaModel => ({} as NovoPlanoEntradaModel);
