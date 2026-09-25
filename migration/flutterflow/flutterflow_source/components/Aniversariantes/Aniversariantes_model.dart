import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'aniversariantes_widget.dart' show AniversariantesWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AniversariantesModel extends FlutterFlowModel<AniversariantesWidget> {
  ///  Local state fields for this component.

  String? mesSelecionado;

  DateTime? inicioMes;

  DateTime? inicioProxMes;

  int? selectedYearPagar;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Nome widget.
  String? nomeValue;
  FormFieldController<String>? nomeValueController;
  // State field(s) for CPF widget.
  String? cpfValue;
  FormFieldController<String>? cpfValueController;
  // State field(s) for Telefone widget.
  String? telefoneValue;
  FormFieldController<String>? telefoneValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Abrir widget.
  List<ClientesRow>? pesquisaGeral;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
