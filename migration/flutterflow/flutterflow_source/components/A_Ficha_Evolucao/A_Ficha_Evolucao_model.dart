import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/vision_smart_beauty/d_evolucao/componentes_evolucao/c_editar_produtos/c_editar_produtos_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/novo_produto/b_novo_produto/b_novo_produto_widget.dart';
import 'dart:convert';
import 'dart:ui';
import 'a_ficha_evolucao_widget.dart' show AFichaEvolucaoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AFichaEvolucaoModel extends FlutterFlowModel<AFichaEvolucaoWidget> {
  ///  Local state fields for this component.

  String? antesEvolucao = '';

  String? depoisEvolucao;

  int? filtroproduto;

  int? idProduto;

  String? tipoEmbalagem;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (rollbackEstoque)] action in Icon widget.
  ApiCallResponse? apiResultvws;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<EstoqueEvolucaoRow>? fechar;
  bool isDataUploading_antes = false;
  FFUploadedFile uploadedLocalFile_antes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_antes = '';

  bool isDataUploading_depois = false;
  FFUploadedFile uploadedLocalFile_depois =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_depois = '';

  // State field(s) for Observcao widget.
  FocusNode? observcaoFocusNode;
  TextEditingController? observcaoTextController;
  String? Function(BuildContext, String?)? observcaoTextControllerValidator;
  // State field(s) for Produtos widget.
  String? produtosValue;
  FormFieldController<String>? produtosValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Produtos widget.
  List<ProdutosRow>? saidaTipo2;
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
    observcaoFocusNode?.dispose();
    observcaoTextController?.dispose();

    tipoEmbalagemFocusNode?.dispose();
    tipoEmbalagemTextController?.dispose();

    quantidadeFocusNode?.dispose();
    quantidadeTextController?.dispose();
  }
}
