import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/alerta/alerta_c_e_p/alerta_c_e_p_widget.dart';
import 'dart:convert';
import 'dart:ui';
import 'buscar_c_e_p_widget.dart' show BuscarCEPWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class BuscarCEPModel extends FlutterFlowModel<BuscarCEPWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Editar_CEP widget.
  FocusNode? editarCEPFocusNode;
  TextEditingController? editarCEPTextController;
  late MaskTextInputFormatter editarCEPMask;
  String? Function(BuildContext, String?)? editarCEPTextControllerValidator;
  // Stores action output result for [Backend Call - API (PuxarCEP)] action in Icon widget.
  ApiCallResponse? apiResultm8x;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    editarCEPFocusNode?.dispose();
    editarCEPTextController?.dispose();
  }
}
