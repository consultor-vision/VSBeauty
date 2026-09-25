import '/auth/supabase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'alteracao_senha_widget.dart' show AlteracaoSenhaWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AlteracaoSenhaModel extends FlutterFlowModel<AlteracaoSenhaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Nova_Senha widget.
  FocusNode? novaSenhaFocusNode;
  TextEditingController? novaSenhaTextController;
  late bool novaSenhaVisibility;
  String? Function(BuildContext, String?)? novaSenhaTextControllerValidator;
  // State field(s) for Confirmar_Senha widget.
  FocusNode? confirmarSenhaFocusNode;
  TextEditingController? confirmarSenhaTextController;
  late bool confirmarSenhaVisibility;
  String? Function(BuildContext, String?)?
      confirmarSenhaTextControllerValidator;

  @override
  void initState(BuildContext context) {
    novaSenhaVisibility = false;
    confirmarSenhaVisibility = false;
  }

  @override
  void dispose() {
    novaSenhaFocusNode?.dispose();
    novaSenhaTextController?.dispose();

    confirmarSenhaFocusNode?.dispose();
    confirmarSenhaTextController?.dispose();
  }
}
