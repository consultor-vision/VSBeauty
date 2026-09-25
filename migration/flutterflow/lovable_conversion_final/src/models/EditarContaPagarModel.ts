// TypeScript model converted from FlutterFlow Editar_Conta_Pagar
// Source: extracted_code/components/Editar_Conta_Pagar/Editar_Conta_Pagar_model.dart

export interface EditarContaPagarModel {
  compraData: Date | null;
  emisssaoData: Date | null;
  tipoPagamento: string | null;
  status: string | null;
  selectedDateEmissao: Date | null;
  selectedDateVencimento: Date | null;
  categoriaValue: string | null;
  categoriaValueController: unknown | null;
  itemValue: string | null;
  itemValueController: unknown | null;
  valorFocusNode: unknown | null;
  valorTextController: unknown | null;
  parcelaFocusNode: unknown | null;
  parcelaTextController: unknown | null;
  parcelaMask: unknown;
  tipoPagamentoValue: string | null;
  tipoPagamentoValueController: unknown | null;
  statusValue: string | null;
  statusValueController: unknown | null;
  observacaoFocusNode: unknown | null;
  observacaoTextController: unknown | null;
  saidaCategoria: unknown[] | null;
  saidaItem: unknown[] | null;
}

export const createEditarContaPagarModel = (): EditarContaPagarModel => ({} as EditarContaPagarModel);
