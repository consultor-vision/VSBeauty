// TypeScript model converted from FlutterFlow Editar_Cadastro
// Source: extracted_code/components/Editar_Cadastro/Editar_Cadastro_model.dart

export interface EditarCadastroModel {
  datanascimento: Date | null;
  imagemCliente: string | null;
  selectedDate: Date | null;
  nomeCompletoFocusNode: unknown | null;
  nomeCompletoTextController: unknown | null;
  telefoneFocusNode: unknown | null;
  telefoneTextController: unknown | null;
  telefoneMask: unknown;
  emailFocusNode: unknown | null;
  emailTextController: unknown | null;
  instagramFocusNode: unknown | null;
  instagramTextController: unknown | null;
  dataNascimentoFocusNode: unknown | null;
  dataNascimentoTextController: unknown | null;
  dataNascimentoMask: unknown;
  dropDownValue: string | null;
  dropDownValueController: unknown | null;
  cpfFocusNode: unknown | null;
  cpfTextController: unknown | null;
  cpfMask: unknown;
  editarCEPFocusNode: unknown | null;
  editarCEPTextController: unknown | null;
  editarCEPMask: unknown;
  logradouroFocusNode: unknown | null;
  logradouroTextController: unknown | null;
  numeroFocusNode: unknown | null;
  numeroTextController: unknown | null;
  complementoFocusNode: unknown | null;
  complementoTextController: unknown | null;
  bairroFocusNode: unknown | null;
  bairroTextController: unknown | null;
  cidadeFocusNode: unknown | null;
  cidadeTextController: unknown | null;
  estadoFocusNode: unknown | null;
  estadoTextController: unknown | null;
}

export const createEditarCadastroModel = (): EditarCadastroModel => ({} as EditarCadastroModel);
