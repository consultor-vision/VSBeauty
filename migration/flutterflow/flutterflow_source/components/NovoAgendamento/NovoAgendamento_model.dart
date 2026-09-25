import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/b_agenda/componentes/alertas/alerta_duplicidade_agenda/alerta_duplicidade_agenda_widget.dart';
import '/vision_smart_beauty/b_agenda/componentes/calendario/agenda_d_p_popover/agenda_d_p_popover_widget.dart';
import '/vision_smart_beauty/b_agenda/componentes/calendario/relogio/relogio_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'novo_agendamento_widget.dart' show NovoAgendamentoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NovoAgendamentoModel extends FlutterFlowModel<NovoAgendamentoWidget> {
  ///  Local state fields for this component.

  DateTime? horaCerta;

  String? verHora;

  DateTime? horaFinalizada;

  ///  State fields for stateful widgets in this component.

  // State field(s) for ddProdcedimento widget.
  String? ddProdcedimentoValue;
  FormFieldController<String>? ddProdcedimentoValueController;
  // Stores action output result for [Backend Call - Query Rows] action in ddProdcedimento widget.
  List<PlanosRow>? planoSaida;
  // Stores action output result for [Backend Call - Query Rows] action in ddProdcedimento widget.
  List<ProcedimentosRow>? procedimentoSaida;
  // State field(s) for ddProfissional widget.
  String? ddProfissionalValue;
  FormFieldController<String>? ddProfissionalValueController;
  // Model for Agenda_DP_Popover component.
  late AgendaDPPopoverModel agendaDPPopoverModel;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<PlanosRow>? outPlano;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<UsuariosRow>? outProfissional;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<AgendamentoRow>? outPlanoContagem;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<AgendamentoRow>? outConflito;

  @override
  void initState(BuildContext context) {
    agendaDPPopoverModel = createModel(context, () => AgendaDPPopoverModel());
  }

  @override
  void dispose() {
    agendaDPPopoverModel.dispose();
  }
}
