// TypeScript model converted from FlutterFlow EditarAgendamento
// Source: extracted_code/components/EditarAgendamento/EditarAgendamento_model.dart

export interface EditarAgendamentoModel {
  data: Date | null;
  horaInicio: Date | null;
  horaFim: Date | null;
  usuario: number | null;
  selectedDate: Date | null;
  outAgendamento: unknown[] | null;
  outPlano: unknown[] | null;
  outProcedimento: unknown[] | null;
  outProfissional: unknown[] | null;
  dropProfissionalValue: string | null;
  dropProfissionalValueController: unknown | null;
  usuarioId: unknown[] | null;
  dropSttAgendamentoValue: string | null;
  dropSttAgendamentoValueController: unknown | null;
  editarHoraFinalFocusNode: unknown | null;
  editarHoraFinalTextController: unknown | null;
  editarHoraFinalMask: unknown;
  outProfissionalEditar: unknown[] | null;
  outAlteradoPor: unknown[] | null;
  outconfliteditar: unknown[] | null;
}

export const createEditarAgendamentoModel = (): EditarAgendamentoModel => ({} as EditarAgendamentoModel);
