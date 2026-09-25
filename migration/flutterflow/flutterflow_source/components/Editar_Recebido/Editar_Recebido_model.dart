import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/g_geral/calendario_popover/calendar_popover/calendar_popover_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'editar_recebido_widget.dart' show EditarRecebidoWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EditarRecebidoModel extends FlutterFlowModel<EditarRecebidoWidget> {
  ///  Local state fields for this component.

  int? idProcedimento;

  String? statusFinanceiro;

  String? formaPagamento;

  DateTime? dataVencimento;

  DateTime? selectedDateEmissao;

  DateTime? selectedDateVencimento;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Data_Emissao widget.
  FocusNode? dataEmissaoFocusNode;
  TextEditingController? dataEmissaoTextController;
  late MaskTextInputFormatter dataEmissaoMask;
  String? Function(BuildContext, String?)? dataEmissaoTextControllerValidator;
  // State field(s) for Categoria_Procedimento widget.
  FocusNode? categoriaProcedimentoFocusNode;
  TextEditingController? categoriaProcedimentoTextController;
  late MaskTextInputFormatter categoriaProcedimentoMask;
  String? Function(BuildContext, String?)?
      categoriaProcedimentoTextControllerValidator;
  // State field(s) for Item widget.
  FocusNode? itemFocusNode;
  TextEditingController? itemTextController;
  late MaskTextInputFormatter itemMask;
  String? Function(BuildContext, String?)? itemTextControllerValidator;
  // State field(s) for Quantidade_Sessao widget.
  FocusNode? quantidadeSessaoFocusNode;
  TextEditingController? quantidadeSessaoTextController;
  late MaskTextInputFormatter quantidadeSessaoMask;
  String? Function(BuildContext, String?)?
      quantidadeSessaoTextControllerValidator;
  // State field(s) for Valor_Procedimento widget.
  FocusNode? valorProcedimentoFocusNode;
  TextEditingController? valorProcedimentoTextController;
  String? Function(BuildContext, String?)?
      valorProcedimentoTextControllerValidator;
  // State field(s) for Forma_Pagamento widget.
  String? formaPagamentoValue;
  FormFieldController<String>? formaPagamentoValueController;
  // State field(s) for Parcelas widget.
  FocusNode? parcelasFocusNode;
  TextEditingController? parcelasTextController;
  late MaskTextInputFormatter parcelasMask;
  String? Function(BuildContext, String?)? parcelasTextControllerValidator;
  // State field(s) for Status_Procedimento widget.
  String? statusProcedimentoValue;
  FormFieldController<String>? statusProcedimentoValueController;
  // State field(s) for Status_financeiro widget.
  String? statusFinanceiroValue;
  FormFieldController<String>? statusFinanceiroValueController;
  // State field(s) for Observacao widget.
  FocusNode? observacaoFocusNode;
  TextEditingController? observacaoTextController;
  String? Function(BuildContext, String?)? observacaoTextControllerValidator;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Excluir widget.
  List<ContaReceberRow>? deleteAgendamento;
  // Stores action output result for [Backend Call - Query Rows] action in editar widget.
  List<ProcedimentosRow>? selecionarProcedimento;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    dataEmissaoFocusNode?.dispose();
    dataEmissaoTextController?.dispose();

    categoriaProcedimentoFocusNode?.dispose();
    categoriaProcedimentoTextController?.dispose();

    itemFocusNode?.dispose();
    itemTextController?.dispose();

    quantidadeSessaoFocusNode?.dispose();
    quantidadeSessaoTextController?.dispose();

    valorProcedimentoFocusNode?.dispose();
    valorProcedimentoTextController?.dispose();

    parcelasFocusNode?.dispose();
    parcelasTextController?.dispose();

    observacaoFocusNode?.dispose();
    observacaoTextController?.dispose();
  }
}
