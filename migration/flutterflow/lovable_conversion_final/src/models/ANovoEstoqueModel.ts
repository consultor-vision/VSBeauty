// TypeScript model converted from FlutterFlow A_Novo_Estoque
// Source: extracted_code/components/A_Novo_Estoque/A_Novo_Estoque_model.dart

export interface ANovoEstoqueModel {
  idProduto: number | null;
  tipoEmbalagem: string | null;
  produtosValue: string | null;
  produtosValueController: unknown | null;
  saidaTipo: unknown[] | null;
  tipoEmbalagemFocusNode: unknown | null;
  tipoEmbalagemTextController: unknown | null;
  quantidadeFocusNode: unknown | null;
  quantidadeTextController: unknown | null;
  trazerId: unknown[] | null;
}

export const createANovoEstoqueModel = (): ANovoEstoqueModel => ({} as ANovoEstoqueModel);
