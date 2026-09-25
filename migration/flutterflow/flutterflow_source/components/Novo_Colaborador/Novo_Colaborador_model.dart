import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/alerta/alerta_falta_dados/alerta_falta_dados_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/a_colaborador/calendario_colaborador/g_colab_d_p_popover/g_colab_d_p_popover_widget.dart';
import 'dart:convert';
import 'dart:ui';
import '/index.dart';
import 'novo_colaborador_widget.dart' show NovoColaboradorWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class NovoColaboradorModel extends FlutterFlowModel<NovoColaboradorWidget> {
  ///  Local state fields for this component.

  DateTime? dataNascimento;

  String? uidColaborador;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Nome_Completo widget.
  FocusNode? nomeCompletoFocusNode;
  TextEditingController? nomeCompletoTextController;
  String? Function(BuildContext, String?)? nomeCompletoTextControllerValidator;
  // Model for G_Colab_DP_Popover component.
  late GColabDPPopoverModel gColabDPPopoverModel;
  // State field(s) for CPF widget.
  FocusNode? cpfFocusNode;
  TextEditingController? cpfTextController;
  late MaskTextInputFormatter cpfMask;
  String? Function(BuildContext, String?)? cpfTextControllerValidator;
  // State field(s) for Telefone widget.
  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneTextController;
  late MaskTextInputFormatter telefoneMask;
  String? Function(BuildContext, String?)? telefoneTextControllerValidator;
  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // Stores action output result for [Backend Call - API (CreateUserSupabase)] action in Salvar widget.
  ApiCallResponse? coladorador;

  @override
  void initState(BuildContext context) {
    gColabDPPopoverModel = createModel(context, () => GColabDPPopoverModel());
  }

  @override
  void dispose() {
    nomeCompletoFocusNode?.dispose();
    nomeCompletoTextController?.dispose();

    gColabDPPopoverModel.dispose();
    cpfFocusNode?.dispose();
    cpfTextController?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
