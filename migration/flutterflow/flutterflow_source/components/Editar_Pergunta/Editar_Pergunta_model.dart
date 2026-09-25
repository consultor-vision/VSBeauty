import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'editar_pergunta_widget.dart' show EditarPerguntaWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditarPerguntaModel extends FlutterFlowModel<EditarPerguntaWidget> {
  ///  Local state fields for this component.

  DateTime? dataNascimento;

  String? uidColaborador;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Pergunta_Anamnese widget.
  FocusNode? perguntaAnamneseFocusNode;
  TextEditingController? perguntaAnamneseTextController;
  String? Function(BuildContext, String?)?
      perguntaAnamneseTextControllerValidator;
  // State field(s) for Caso_Sim widget.
  FocusNode? casoSimFocusNode;
  TextEditingController? casoSimTextController;
  String? Function(BuildContext, String?)? casoSimTextControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Excluir widget.
  List<AnamneseRow>? pesquisa;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    perguntaAnamneseFocusNode?.dispose();
    perguntaAnamneseTextController?.dispose();

    casoSimFocusNode?.dispose();
    casoSimTextController?.dispose();
  }
}
