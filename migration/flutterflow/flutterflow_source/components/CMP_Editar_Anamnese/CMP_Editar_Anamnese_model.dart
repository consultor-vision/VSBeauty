import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'c_m_p_editar_anamnese_widget.dart' show CMPEditarAnamneseWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CMPEditarAnamneseModel extends FlutterFlowModel<CMPEditarAnamneseWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Sim_Nao widget.
  String? simNaoValue;
  FormFieldController<String>? simNaoValueController;
  // State field(s) for Complemento widget.
  FocusNode? complementoFocusNode;
  TextEditingController? complementoTextController;
  String? Function(BuildContext, String?)? complementoTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    complementoFocusNode?.dispose();
    complementoTextController?.dispose();
  }
}
