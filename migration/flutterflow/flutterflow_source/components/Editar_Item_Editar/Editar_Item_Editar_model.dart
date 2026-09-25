import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'editar_item_editar_widget.dart' show EditarItemEditarWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditarItemEditarModel extends FlutterFlowModel<EditarItemEditarWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Campo_Item widget.
  FocusNode? campoItemFocusNode;
  TextEditingController? campoItemTextController;
  String? Function(BuildContext, String?)? campoItemTextControllerValidator;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Deletar widget.
  List<ItemFinanceiroRow>? deletar;
  // Stores action output result for [Backend Call - Update Row(s)] action in Salvar widget.
  List<ItemFinanceiroRow>? deletarCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    campoItemFocusNode?.dispose();
    campoItemTextController?.dispose();
  }
}
