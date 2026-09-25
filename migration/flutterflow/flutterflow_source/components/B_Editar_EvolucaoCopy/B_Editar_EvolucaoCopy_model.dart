import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/vision_smart_beauty/d_evolucao/componentes_evolucao/c_editar_produtos/c_editar_produtos_widget.dart';
import 'dart:convert';
import 'dart:ui';
import 'b_editar_evolucao_copy_widget.dart' show BEditarEvolucaoCopyWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BEditarEvolucaoCopyModel
    extends FlutterFlowModel<BEditarEvolucaoCopyWidget> {
  ///  Local state fields for this component.

  String? antesEvolucao = '';

  String? depoisEvolucao;

  int? filtroproduto;

  int? idProduto;

  String? tipoEmbalagem;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in B_Editar_EvolucaoCopy widget.
  List<EvolucaoClienteRow>? fotos;
  // Stores action output result for [Backend Call - API (rollbackEstoque)] action in Icon widget.
  ApiCallResponse? apiResultvws;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<EstoqueEvolucaoRow>? fechar;
  bool isDataUploading_editarantes = false;
  FFUploadedFile uploadedLocalFile_editarantes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_editarantes = '';

  bool isDataUploading_editardepois = false;
  FFUploadedFile uploadedLocalFile_editardepois =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_editardepois = '';

  // State field(s) for Observcao widget.
  FocusNode? observcaoFocusNode;
  TextEditingController? observcaoTextController;
  String? Function(BuildContext, String?)? observcaoTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    observcaoFocusNode?.dispose();
    observcaoTextController?.dispose();
  }
}
