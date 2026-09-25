import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'editar_plano_entrada_widget.dart' show EditarPlanoEntradaWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EditarPlanoEntradaModel
    extends FlutterFlowModel<EditarPlanoEntradaWidget> {
  ///  Local state fields for this component.

  int? idProcedimento;

  ///  State fields for stateful widgets in this component.

  // State field(s) for procedimento widget.
  String? procedimentoValue;
  FormFieldController<String>? procedimentoValueController;
  // State field(s) for quant_sessao widget.
  FocusNode? quantSessaoFocusNode;
  TextEditingController? quantSessaoTextController;
  late MaskTextInputFormatter quantSessaoMask;
  String? Function(BuildContext, String?)? quantSessaoTextControllerValidator;
  // State field(s) for valorProcedimento widget.
  FocusNode? valorProcedimentoFocusNode;
  TextEditingController? valorProcedimentoTextController;
  String? Function(BuildContext, String?)?
      valorProcedimentoTextControllerValidator;
  // State field(s) for formaPagamento widget.
  String? formaPagamentoValue;
  FormFieldController<String>? formaPagamentoValueController;
  // State field(s) for parcelas widget.
  FocusNode? parcelasFocusNode;
  TextEditingController? parcelasTextController;
  late MaskTextInputFormatter parcelasMask;
  String? Function(BuildContext, String?)? parcelasTextControllerValidator;
  // State field(s) for statusprocedimento widget.
  String? statusprocedimentoValue;
  FormFieldController<String>? statusprocedimentoValueController;
  // State field(s) for Status_Financeiro widget.
  String? statusFinanceiroValue;
  FormFieldController<String>? statusFinanceiroValueController;
  // Stores action output result for [Backend Call - Query Rows] action in editar widget.
  List<ProcedimentosRow>? selecionarProcedimento;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    quantSessaoFocusNode?.dispose();
    quantSessaoTextController?.dispose();

    valorProcedimentoFocusNode?.dispose();
    valorProcedimentoTextController?.dispose();

    parcelasFocusNode?.dispose();
    parcelasTextController?.dispose();
  }
}
