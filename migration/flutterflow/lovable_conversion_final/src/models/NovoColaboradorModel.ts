// TypeScript model converted from FlutterFlow Novo_Colaborador
// Source: extracted_code/components/Novo_Colaborador/Novo_Colaborador_model.dart

export interface NovoColaboradorModel {
  dataNascimento: Date | null;
  uidColaborador: string | null;
  nomeCompletoFocusNode: unknown | null;
  nomeCompletoTextController: unknown | null;
  cpfFocusNode: unknown | null;
  cpfTextController: unknown | null;
  cpfMask: unknown;
  telefoneFocusNode: unknown | null;
  telefoneTextController: unknown | null;
  telefoneMask: unknown;
  emailFocusNode: unknown | null;
  emailTextController: unknown | null;
  switchValue1: boolean | null;
  switchValue2: boolean | null;
}

export const createNovoColaboradorModel = (): NovoColaboradorModel => ({} as NovoColaboradorModel);
