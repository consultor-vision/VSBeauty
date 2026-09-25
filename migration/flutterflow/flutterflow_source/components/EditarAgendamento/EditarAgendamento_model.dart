import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/b_agenda/componentes/alertas/alerta_duplicidade_agenda/alerta_duplicidade_agenda_widget.dart';
import '/vision_smart_beauty/b_agenda/componentes/calendario/relogio/relogio_widget.dart';
import '/vision_smart_beauty/g_geral/calendario_popover/calendar_popover/calendar_popover_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'editar_agendamento_widget.dart' show EditarAgendamentoWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EditarAgendamentoModel extends FlutterFlowModel<EditarAgendamentoWidget> {
  ///  Local state fields for this component.

  DateTime? data;

  DateTime? horaInicio;

  DateTime? horaFim;

  int? usuario;

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in EditarAgendamento widget.
  List<AgendamentoRow>? outAgendamento;
  // Stores action output result for [Backend Call - Query Rows] action in EditarAgendamento widget.
  List<PlanosRow>? outPlano;
  // Stores action output result for [Backend Call - Query Rows] action in EditarAgendamento widget.
  List<ProcedimentosRow>? outProcedimento;
  // Stores action output result for [Backend Call - Query Rows] action in EditarAgendamento widget.
  List<UsuariosRow>? outProfissional;
  // State field(s) for DropProfissional widget.
  String? dropProfissionalValue;
  FormFieldController<String>? dropProfissionalValueController;
  // Stores action output result for [Backend Call - Query Rows] action in DropProfissional widget.
  List<UsuariosRow>? usuarioId;
  // State field(s) for DropSttAgendamento widget.
  String? dropSttAgendamentoValue;
  FormFieldController<String>? dropSttAgendamentoValueController;
  // State field(s) for Editar_Hora_Final widget.
  FocusNode? editarHoraFinalFocusNode;
  TextEditingController? editarHoraFinalTextController;
  late MaskTextInputFormatter editarHoraFinalMask;
  String? Function(BuildContext, String?)?
      editarHoraFinalTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<UsuariosRow>? outProfissionalEditar;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<UsuariosRow>? outAlteradoPor;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<AgendamentoRow>? outconfliteditar;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    editarHoraFinalFocusNode?.dispose();
    editarHoraFinalTextController?.dispose();
  }
}
