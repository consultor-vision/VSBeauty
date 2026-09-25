import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'edicao_procedimento_widget.dart' show EdicaoProcedimentoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EdicaoProcedimentoModel
    extends FlutterFlowModel<EdicaoProcedimentoWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Novo_Procedimentos widget.
  FocusNode? novoProcedimentosFocusNode;
  TextEditingController? novoProcedimentosTextController;
  String? Function(BuildContext, String?)?
      novoProcedimentosTextControllerValidator;
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
  // State field(s) for Valor_Procedimento widget.
  FocusNode? valorProcedimentoFocusNode;
  TextEditingController? valorProcedimentoTextController;
  String? Function(BuildContext, String?)?
      valorProcedimentoTextControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    novoProcedimentosFocusNode?.dispose();
    novoProcedimentosTextController?.dispose();

    duracaoFocusNode?.dispose();
    duracaoTextController?.dispose();

    intervaloFocusNode?.dispose();
    intervaloTextController?.dispose();

    valorProcedimentoFocusNode?.dispose();
    valorProcedimentoTextController?.dispose();
  }
}
