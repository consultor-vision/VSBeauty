import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'novo_procedimento_widget.dart' show NovoProcedimentoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class NovoProcedimentoModel extends FlutterFlowModel<NovoProcedimentoWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Nome_Procedimento widget.
  FocusNode? nomeProcedimentoFocusNode;
  TextEditingController? nomeProcedimentoTextController;
  String? Function(BuildContext, String?)?
      nomeProcedimentoTextControllerValidator;
  // State field(s) for duracao widget.
  FocusNode? duracaoFocusNode;
  TextEditingController? duracaoTextController;
  late MaskTextInputFormatter duracaoMask;
  String? Function(BuildContext, String?)? duracaoTextControllerValidator;
  // State field(s) for Intervalo widget.
  FocusNode? intervaloFocusNode;
  TextEditingController? intervaloTextController;
  late MaskTextInputFormatter intervaloMask;
  String? Function(BuildContext, String?)? intervaloTextControllerValidator;
  // State field(s) for valor widget.
  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  String? Function(BuildContext, String?)? valorTextControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomeProcedimentoFocusNode?.dispose();
    nomeProcedimentoTextController?.dispose();

    duracaoFocusNode?.dispose();
    duracaoTextController?.dispose();

    intervaloFocusNode?.dispose();
    intervaloTextController?.dispose();

    valorFocusNode?.dispose();
    valorTextController?.dispose();
  }
}
