import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/b_agenda/componentes/alertas/alerta_agendamento/alerta_agendamento_widget.dart';
import '/vision_smart_beauty/b_agenda/componentes/aniversariantes/aniversariantes_widget.dart';
import '/vision_smart_beauty/b_agenda/componentes/cadastro_agendamento/cadastro_agendamento_widget.dart';
import '/vision_smart_beauty/b_agenda/componentes/editar_agendamento/editar_agendamento_widget.dart';
import '/vision_smart_beauty/d_evolucao/componentes_evolucao/a_ficha_evolucao/a_ficha_evolucao_widget.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'agenda_widget.dart' show AgendaWidget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AgendaModel extends FlutterFlowModel<AgendaWidget> {
  ///  Local state fields for this page.

  DateTime? dataInicio;

  DateTime? dataFim;

  DateTime? calendario;

  DateTime? selectedDate;

  bool mostrarAgendamentos = false;

  String? telaAgendamento;

  int? selectedClienteId;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Filtro_Cliente widget.
  int? filtroClienteValue;
  FormFieldController<int>? filtroClienteValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Filtro_Cliente widget.
  List<ClientesRow>? filtrarCliente;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - Query Rows] action in IconButton widget.
  List<ClientesRow>? encontrarCliente2;
  // Stores action output result for [Backend Call - Query Rows] action in IconButton widget.
  List<PlanosRow>? buscaProcedimento2;
  // Stores action output result for [Backend Call - Query Rows] action in IconButton widget.
  List<ProcedimentosRow>? trocaNomeProcedimento2;
  // Model for Menu_Central component.
  late MenuCentralModel menuCentralModel;

  @override
  void initState(BuildContext context) {
    menuCentralModel = createModel(context, () => MenuCentralModel());
  }

  @override
  void dispose() {
    menuCentralModel.dispose();
  }
}
