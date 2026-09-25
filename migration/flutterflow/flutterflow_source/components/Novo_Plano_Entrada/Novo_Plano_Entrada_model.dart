import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'novo_plano_entrada_widget.dart' show NovoPlanoEntradaWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class NovoPlanoEntradaModel extends FlutterFlowModel<NovoPlanoEntradaWidget> {
  ///  Local state fields for this component.

  int? idprocedimento;

  int? idPlano;

  double? pvValorProcedimento;

  int? pvQtdSessoes;

  double? valorTotal;

  ///  State fields for stateful widgets in this component.

  // State field(s) for procedimento widget.
  String? procedimentoValue;
  FormFieldController<String>? procedimentoValueController;
  // Stores action output result for [Backend Call - Query Rows] action in procedimento widget.
  List<ProcedimentosRow>? outProcedimento;
  // State field(s) for quant_sessao widget.
  FocusNode? quantSessaoFocusNode;
  TextEditingController? quantSessaoTextController;
  late MaskTextInputFormatter quantSessaoMask;
  String? Function(BuildContext, String?)? quantSessaoTextControllerValidator;
  // State field(s) for Valor_procedimento widget.
  FocusNode? valorProcedimentoFocusNode;
  TextEditingController? valorProcedimentoTextController;
  String? Function(BuildContext, String?)?
      valorProcedimentoTextControllerValidator;
  // State field(s) for Valor_Entrada widget.
  FocusNode? valorEntradaFocusNode;
  TextEditingController? valorEntradaTextController;
  String? Function(BuildContext, String?)? valorEntradaTextControllerValidator;
  // State field(s) for Valor_Total widget.
  FocusNode? valorTotalFocusNode;
  TextEditingController? valorTotalTextController;
  String? Function(BuildContext, String?)? valorTotalTextControllerValidator;
  // State field(s) for formaPagamento widget.
  String? formaPagamentoValue;
  FormFieldController<String>? formaPagamentoValueController;
  // State field(s) for Parcelas widget.
  FocusNode? parcelasFocusNode;
  TextEditingController? parcelasTextController;
  late MaskTextInputFormatter parcelasMask;
  String? Function(BuildContext, String?)? parcelasTextControllerValidator;
  // State field(s) for Stt_Financeiro widget.
  String? sttFinanceiroValue;
  FormFieldController<String>? sttFinanceiroValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<ProcedimentosRow>? selecionarProcedimento;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  PlanosRow? entradaID;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    quantSessaoFocusNode?.dispose();
    quantSessaoTextController?.dispose();

    valorProcedimentoFocusNode?.dispose();
    valorProcedimentoTextController?.dispose();

    valorEntradaFocusNode?.dispose();
    valorEntradaTextController?.dispose();

    valorTotalFocusNode?.dispose();
    valorTotalTextController?.dispose();

    parcelasFocusNode?.dispose();
    parcelasTextController?.dispose();
  }
}
