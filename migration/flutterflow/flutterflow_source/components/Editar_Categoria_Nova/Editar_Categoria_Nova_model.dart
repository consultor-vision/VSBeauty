import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'editar_categoria_nova_widget.dart' show EditarCategoriaNovaWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditarCategoriaNovaModel
    extends FlutterFlowModel<EditarCategoriaNovaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Nome_Categoria widget.
  FocusNode? nomeCategoriaFocusNode;
  TextEditingController? nomeCategoriaTextController;
  String? Function(BuildContext, String?)? nomeCategoriaTextControllerValidator;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Deletar widget.
  List<CategoriaRow>? deletar;
  // Stores action output result for [Backend Call - Update Row(s)] action in Salvar widget.
  List<CategoriaRow>? deletarCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomeCategoriaFocusNode?.dispose();
    nomeCategoriaTextController?.dispose();
  }
}
