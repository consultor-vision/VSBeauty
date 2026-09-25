// TypeScript model converted from FlutterFlow Conta_Pagar
// Source: extracted_code/components/Conta_Pagar/Conta_Pagar_model.dart

export interface ContaPagarModel {
  dataEmissao: Date | null;
  dataPagamento: Date | null;
  categoriaValue: string | null;
  categoriaValueController: unknown | null;
  itemValue: string | null;
  itemValueController: unknown | null;
  valorFocusNode: unknown | null;
  valorTextController: unknown | null;
  parcelaFocusNode: unknown | null;
  parcelaTextController: unknown | null;
  tipoPagamentoValue: string | null;
  tipoPagamentoValueController: unknown | null;
  statusValue: string | null;
  statusValueController: unknown | null;
  observacaoFocusNode: unknown | null;
  observacaoTextController: unknown | null;
  outCategoria: unknown[] | null;
  outItem: unknown[] | null;
}

export const createContaPagarModel = (): ContaPagarModel => ({} as ContaPagarModel);
