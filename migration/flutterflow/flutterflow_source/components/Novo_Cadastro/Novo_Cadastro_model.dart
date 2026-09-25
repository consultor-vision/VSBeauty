import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/alerta/alerta_c_e_p/alerta_c_e_p_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/alerta/alerta_c_p_f_duplicado/alerta_c_p_f_duplicado_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/alerta/alerta_falta_dados/alerta_falta_dados_widget.dart';
import 'dart:convert';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'novo_cadastro_widget.dart' show NovoCadastroWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class NovoCadastroModel extends FlutterFlowModel<NovoCadastroWidget> {
  ///  Local state fields for this component.

  DateTime? dataNascimento;

  String? imagemCliente = '';

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_imagemUpload11 = false;
  FFUploadedFile uploadedLocalFile_imagemUpload11 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_imagemUpload11 = '';

  // State field(s) for Nome_Completo widget.
  FocusNode? nomeCompletoFocusNode;
  TextEditingController? nomeCompletoTextController;
  String? Function(BuildContext, String?)? nomeCompletoTextControllerValidator;
  // State field(s) for Telefone widget.
  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneTextController;
  late MaskTextInputFormatter telefoneMask;
  String? Function(BuildContext, String?)? telefoneTextControllerValidator;
  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for Instagram widget.
  FocusNode? instagramFocusNode;
  TextEditingController? instagramTextController;
  String? Function(BuildContext, String?)? instagramTextControllerValidator;
  // State field(s) for Data_Nascimento widget.
  FocusNode? dataNascimentoFocusNode;
  TextEditingController? dataNascimentoTextController;
  late MaskTextInputFormatter dataNascimentoMask;
  String? Function(BuildContext, String?)?
      dataNascimentoTextControllerValidator;
  // State field(s) for Genero widget.
  String? generoValue;
  FormFieldController<String>? generoValueController;
  // State field(s) for CPF widget.
  FocusNode? cpfFocusNode;
  TextEditingController? cpfTextController;
  late MaskTextInputFormatter cpfMask;
  String? Function(BuildContext, String?)? cpfTextControllerValidator;
  // State field(s) for CEP widget.
  FocusNode? cepFocusNode;
  TextEditingController? cepTextController;
  late MaskTextInputFormatter cepMask;
  String? Function(BuildContext, String?)? cepTextControllerValidator;
  // Stores action output result for [Backend Call - API (PuxarCEP)] action in Icon widget.
  ApiCallResponse? apiResultm8x;
  // State field(s) for logradouro widget.
  FocusNode? logradouroFocusNode;
  TextEditingController? logradouroTextController;
  String? Function(BuildContext, String?)? logradouroTextControllerValidator;
  // State field(s) for numero widget.
  FocusNode? numeroFocusNode;
  TextEditingController? numeroTextController;
  String? Function(BuildContext, String?)? numeroTextControllerValidator;
  // State field(s) for Complemento widget.
  FocusNode? complementoFocusNode;
  TextEditingController? complementoTextController;
  String? Function(BuildContext, String?)? complementoTextControllerValidator;
  // State field(s) for Bairro widget.
  FocusNode? bairroFocusNode;
  TextEditingController? bairroTextController;
  String? Function(BuildContext, String?)? bairroTextControllerValidator;
  // State field(s) for Cidade widget.
  FocusNode? cidadeFocusNode;
  TextEditingController? cidadeTextController;
  String? Function(BuildContext, String?)? cidadeTextControllerValidator;
  // State field(s) for Estado widget.
  FocusNode? estadoFocusNode;
  TextEditingController? estadoTextController;
  String? Function(BuildContext, String?)? estadoTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Salvar widget.
  List<ClientesRow>? dif2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomeCompletoFocusNode?.dispose();
    nomeCompletoTextController?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    instagramFocusNode?.dispose();
    instagramTextController?.dispose();

    dataNascimentoFocusNode?.dispose();
    dataNascimentoTextController?.dispose();

    cpfFocusNode?.dispose();
    cpfTextController?.dispose();

    cepFocusNode?.dispose();
    cepTextController?.dispose();

    logradouroFocusNode?.dispose();
    logradouroTextController?.dispose();

    numeroFocusNode?.dispose();
    numeroTextController?.dispose();

    complementoFocusNode?.dispose();
    complementoTextController?.dispose();

    bairroFocusNode?.dispose();
    bairroTextController?.dispose();

    cidadeFocusNode?.dispose();
    cidadeTextController?.dispose();

    estadoFocusNode?.dispose();
    estadoTextController?.dispose();
  }
}
