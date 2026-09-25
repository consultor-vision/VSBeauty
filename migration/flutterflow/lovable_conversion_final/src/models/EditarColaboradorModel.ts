// TypeScript model converted from FlutterFlow Editar_Colaborador
// Source: extracted_code/components/Editar_Colaborador/Editar_Colaborador_model.dart

export interface EditarColaboradorModel {
  dataNascimento: Date | null;
  uidColaborador: string | null;
  selectedDate: Date | null;
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

export const createEditarColaboradorModel = (): EditarColaboradorModel => ({} as EditarColaboradorModel);
