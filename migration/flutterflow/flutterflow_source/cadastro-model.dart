import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/anamnese/editar_ficha/editar_ficha_anamnese/editar_ficha_anamnese_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/anamnese/nova_ficha/nova_ficha_anamnese_copy/nova_ficha_anamnese_copy_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/cadastro/agendamento_cadastro/agendamento_cadastro_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/cadastro/cadastro_geral/cadastro_geral_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/cadastro/editar_cadastro/editar_cadastro_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/cadastro/novo_cadastro/novo_cadastro_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/plano/editar_plano_copy/editar_plano_copy_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/plano/historico_plano/historico_plano_widget.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/plano/novo_plano_copy/novo_plano_copy_widget.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:ui';
import 'cadastro_widget.dart' show CadastroWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class CadastroModel extends FlutterFlowModel<CadastroWidget> {
  ///  Local state fields for this page.

  String cpfCliente = 'CPF';

  String nomeCliente = 'Nome Completo';

  String emailCliente = 'Email';

  String telefoneCliente = 'Telefone';

  DateTime? dataCliente;

  String generoCliente = 'Gênero';

  String? fotoCliente = '';

  int? idCliente;

  String logradouroCliente = 'Logradouro';

  String numeroCliente = 'Número';

  String cepCliente = 'CEP';

  String complementoCliente = 'Complemento';

  String bairroCliente = 'Bairro';

  String cidadeCliente = 'Cidade';

  String estadoCliente = 'Estado';

  int? quantidadeS;

  int? clienteFoco;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Cadastro widget.
  List<AgendamentoRow>? agenda;
  // State field(s) for Linha_1 widget.
  FocusNode? linha1FocusNode;
  TextEditingController? linha1TextController;
  String? Function(BuildContext, String?)? linha1TextControllerValidator;
  // State field(s) for Data_Nasc widget.
  FocusNode? dataNascFocusNode;
  TextEditingController? dataNascTextController;
  String? Function(BuildContext, String?)? dataNascTextControllerValidator;
  // State field(s) for Genero widget.
  FocusNode? generoFocusNode;
  TextEditingController? generoTextController;
  String? Function(BuildContext, String?)? generoTextControllerValidator;
  // State field(s) for CPF widget.
  FocusNode? cpfFocusNode;
  TextEditingController? cpfTextController;
  late MaskTextInputFormatter cpfMask;
  String? Function(BuildContext, String?)? cpfTextControllerValidator;
  // State field(s) for Telefone widget.
  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneTextController;
  String? Function(BuildContext, String?)? telefoneTextControllerValidator;
  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for Instagram widget.
  FocusNode? instagramFocusNode;
  TextEditingController? instagramTextController;
  String? Function(BuildContext, String?)? instagramTextControllerValidator;
  // State field(s) for Linha_4 widget.
  FocusNode? linha4FocusNode;
  TextEditingController? linha4TextController;
  String? Function(BuildContext, String?)? linha4TextControllerValidator;
  // State field(s) for numero widget.
  FocusNode? numeroFocusNode;
  TextEditingController? numeroTextController;
  String? Function(BuildContext, String?)? numeroTextControllerValidator;
  // State field(s) for CEP widget.
  FocusNode? cepFocusNode;
  TextEditingController? cepTextController;
  late MaskTextInputFormatter cepMask;
  String? Function(BuildContext, String?)? cepTextControllerValidator;
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
  // Model for Menu_Central component.
  late MenuCentralModel menuCentralModel;

  @override
  void initState(BuildContext context) {
    menuCentralModel = createModel(context, () => MenuCentralModel());
  }

  @override
  void dispose() {
    linha1FocusNode?.dispose();
    linha1TextController?.dispose();

    dataNascFocusNode?.dispose();
    dataNascTextController?.dispose();

    generoFocusNode?.dispose();
    generoTextController?.dispose();

    cpfFocusNode?.dispose();
    cpfTextController?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    instagramFocusNode?.dispose();
    instagramTextController?.dispose();

    linha4FocusNode?.dispose();
    linha4TextController?.dispose();

    numeroFocusNode?.dispose();
    numeroTextController?.dispose();

    cepFocusNode?.dispose();
    cepTextController?.dispose();

    complementoFocusNode?.dispose();
    complementoTextController?.dispose();

    bairroFocusNode?.dispose();
    bairroTextController?.dispose();

    cidadeFocusNode?.dispose();
    cidadeTextController?.dispose();

    estadoFocusNode?.dispose();
    estadoTextController?.dispose();

    menuCentralModel.dispose();
  }
}
