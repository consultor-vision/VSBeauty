// TypeScript model converted from FlutterFlow Editar_Pergunta
// Source: extracted_code/components/Editar_Pergunta/Editar_Pergunta_model.dart

export interface EditarPerguntaModel {
  dataNascimento: Date | null;
  uidColaborador: string | null;
  perguntaAnamneseFocusNode: unknown | null;
  perguntaAnamneseTextController: unknown | null;
  casoSimFocusNode: unknown | null;
  casoSimTextController: unknown | null;
  pesquisa: unknown[] | null;
}

export const createEditarPerguntaModel = (): EditarPerguntaModel => ({} as EditarPerguntaModel);
