// TypeScript model converted from FlutterFlow Nova_Pergunta
// Source: extracted_code/components/Nova_Pergunta/Nova_Pergunta_model.dart

export interface NovaPerguntaModel {
  dataNascimento: Date | null;
  uidColaborador: string | null;
  perguntaAnamneseFocusNode: unknown | null;
  perguntaAnamneseTextController: unknown | null;
  casoSimFocusNode: unknown | null;
  casoSimTextController: unknown | null;
}

export const createNovaPerguntaModel = (): NovaPerguntaModel => ({} as NovaPerguntaModel);
