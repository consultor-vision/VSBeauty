import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/novo_produto/a_novo_estoque/a_novo_estoque_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/novo_produto/c_editar_produto/c_editar_produto_widget.dart';
import 'dart:ui';
import 'b_novo_produto_widget.dart' show BNovoProdutoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BNovoProdutoModel extends FlutterFlowModel<BNovoProdutoWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Produto widget.
  FocusNode? produtoFocusNode;
  TextEditingController? produtoTextController;
  String? Function(BuildContext, String?)? produtoTextControllerValidator;
  // State field(s) for Tipo_Embalagens widget.
  String? tipoEmbalagensValue;
  FormFieldController<String>? tipoEmbalagensValueController;
  // Stores action output result for [Backend Call - Insert Row] action in Salvar widget.
  ProdutosRow? inserir;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    produtoFocusNode?.dispose();
    produtoTextController?.dispose();
  }
}
