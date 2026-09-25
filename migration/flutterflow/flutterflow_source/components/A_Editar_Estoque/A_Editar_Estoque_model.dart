import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/editar_geral/b_alerta_campos_editar/b_alerta_campos_editar_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'a_editar_estoque_widget.dart' show AEditarEstoqueWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AEditarEstoqueModel extends FlutterFlowModel<AEditarEstoqueWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Produto widget.
  FocusNode? produtoFocusNode;
  TextEditingController? produtoTextController;
  String? Function(BuildContext, String?)? produtoTextControllerValidator;
  // State field(s) for Medida widget.
  FocusNode? medidaFocusNode;
  TextEditingController? medidaTextController;
  String? Function(BuildContext, String?)? medidaTextControllerValidator;
  // State field(s) for Quantidade_Estoque widget.
  FocusNode? quantidadeEstoqueFocusNode;
  TextEditingController? quantidadeEstoqueTextController;
  String? Function(BuildContext, String?)?
      quantidadeEstoqueTextControllerValidator;
  // State field(s) for Quantidade_Utilizada widget.
  FocusNode? quantidadeUtilizadaFocusNode;
  TextEditingController? quantidadeUtilizadaTextController;
  String? Function(BuildContext, String?)?
      quantidadeUtilizadaTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Excluir widget.
  List<ProdutosRow>? trazerIdEditarCopy;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<ProdutosRow>? trazerIdEditar;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    produtoFocusNode?.dispose();
    produtoTextController?.dispose();

    medidaFocusNode?.dispose();
    medidaTextController?.dispose();

    quantidadeEstoqueFocusNode?.dispose();
    quantidadeEstoqueTextController?.dispose();

    quantidadeUtilizadaFocusNode?.dispose();
    quantidadeUtilizadaTextController?.dispose();
  }
}
