import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/novo_produto/b_novo_produto/b_novo_produto_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/novo_produto/d_alerta_campos/d_alerta_campos_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'a_novo_estoque_widget.dart' show ANovoEstoqueWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ANovoEstoqueModel extends FlutterFlowModel<ANovoEstoqueWidget> {
  ///  Local state fields for this component.

  int? idProduto;

  String? tipoEmbalagem;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Produtos widget.
  String? produtosValue;
  FormFieldController<String>? produtosValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Produtos widget.
  List<ProdutosRow>? saidaTipo;
  // State field(s) for Tipo_Embalagem widget.
  FocusNode? tipoEmbalagemFocusNode;
  TextEditingController? tipoEmbalagemTextController;
  String? Function(BuildContext, String?)? tipoEmbalagemTextControllerValidator;
  // State field(s) for Quantidade widget.
  FocusNode? quantidadeFocusNode;
  TextEditingController? quantidadeTextController;
  String? Function(BuildContext, String?)? quantidadeTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<ProdutosRow>? trazerId;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tipoEmbalagemFocusNode?.dispose();
    tipoEmbalagemTextController?.dispose();

    quantidadeFocusNode?.dispose();
    quantidadeTextController?.dispose();
  }
}
