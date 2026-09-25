// TypeScript model converted from FlutterFlow Editar_Recebido
// Source: extracted_code/components/Editar_Recebido/Editar_Recebido_model.dart

export interface EditarRecebidoModel {
  idProcedimento: number | null;
  statusFinanceiro: string | null;
  formaPagamento: string | null;
  dataVencimento: Date | null;
  selectedDateEmissao: Date | null;
  selectedDateVencimento: Date | null;
  dataEmissaoFocusNode: unknown | null;
  dataEmissaoTextController: unknown | null;
  dataEmissaoMask: unknown;
  categoriaProcedimentoFocusNode: unknown | null;
  categoriaProcedimentoTextController: unknown | null;
  categoriaProcedimentoMask: unknown;
  itemFocusNode: unknown | null;
  itemTextController: unknown | null;
  itemMask: unknown;
  quantidadeSessaoFocusNode: unknown | null;
  quantidadeSessaoTextController: unknown | null;
  quantidadeSessaoMask: unknown;
  valorProcedimentoFocusNode: unknown | null;
  valorProcedimentoTextController: unknown | null;
  formaPagamentoValue: string | null;
  formaPagamentoValueController: unknown | null;
  parcelasFocusNode: unknown | null;
  parcelasTextController: unknown | null;
  parcelasMask: unknown;
  statusProcedimentoValue: string | null;
  statusProcedimentoValueController: unknown | null;
  statusFinanceiroValue: string | null;
  statusFinanceiroValueController: unknown | null;
  observacaoFocusNode: unknown | null;
  observacaoTextController: unknown | null;
  deleteAgendamento: unknown[] | null;
  selecionarProcedimento: unknown[] | null;
}

export const createEditarRecebidoModel = (): EditarRecebidoModel => ({} as EditarRecebidoModel);
