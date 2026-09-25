import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'd_cliente_evolucao_widget.dart' show DClienteEvolucaoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DClienteEvolucaoModel extends FlutterFlowModel<DClienteEvolucaoWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for ddNome widget.
  String? ddNomeValue;
  FormFieldController<String>? ddNomeValueController;
  // State field(s) for ddCpf widget.
  String? ddCpfValue;
  FormFieldController<String>? ddCpfValueController;
  // State field(s) for DDTelefone widget.
  String? dDTelefoneValue;
  FormFieldController<String>? dDTelefoneValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<AgendamentoRow>? agendamentoEvolucao;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
