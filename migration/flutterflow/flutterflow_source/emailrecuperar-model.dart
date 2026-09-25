import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:convert';
import 'dart:ui';
import '/index.dart';
import 'email_recuperacao_widget.dart' show EmailRecuperacaoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailRecuperacaoModel extends FlutterFlowModel<EmailRecuperacaoWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for emailRecuperaca widget.
  FocusNode? emailRecuperacaFocusNode;
  TextEditingController? emailRecuperacaTextController;
  String? Function(BuildContext, String?)?
      emailRecuperacaTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailRecuperacaFocusNode?.dispose();
    emailRecuperacaTextController?.dispose();
  }
}
