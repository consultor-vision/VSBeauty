import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/alerta/alerta_falta_dados/alerta_falta_dados_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/dim_pagar/dim_categoria/editar/categoria_editar/categoria_editar_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/dim_pagar/dim_item_financeiro/editar/item_editar/item_editar_widget.dart';
import '/vision_smart_beauty/g_geral/calendario_popover/calendar_popover/calendar_popover_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'editar_conta_pagar_widget.dart' show EditarContaPagarWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EditarContaPagarModel extends FlutterFlowModel<EditarContaPagarWidget> {
  ///  Local state fields for this component.

  DateTime? compraData;

  DateTime? emisssaoData;

  String? tipoPagamento;

  String? status;

  DateTime? selectedDateEmissao;

  DateTime? selectedDateVencimento;

  ///  State fields for stateful widgets in this component.

  // State field(s) for categoria widget.
  String? categoriaValue;
  FormFieldController<String>? categoriaValueController;
  // State field(s) for item widget.
  String? itemValue;
  FormFieldController<String>? itemValueController;
  // State field(s) for valor widget.
  FocusNode? valorFocusNode;
  TextEditingController? valorTextController;
  String? Function(BuildContext, String?)? valorTextControllerValidator;
  // State field(s) for Parcela widget.
  FocusNode? parcelaFocusNode;
  TextEditingController? parcelaTextController;
  late MaskTextInputFormatter parcelaMask;
  String? Function(BuildContext, String?)? parcelaTextControllerValidator;
  // State field(s) for Tipo_Pagamento widget.
  String? tipoPagamentoValue;
  FormFieldController<String>? tipoPagamentoValueController;
  // State field(s) for Status widget.
  String? statusValue;
  FormFieldController<String>? statusValueController;
  // State field(s) for Observacao widget.
  FocusNode? observacaoFocusNode;
  TextEditingController? observacaoTextController;
  String? Function(BuildContext, String?)? observacaoTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Editar widget.
  List<CategoriaRow>? saidaCategoria;
  // Stores action output result for [Backend Call - Query Rows] action in Editar widget.
  List<ItemFinanceiroRow>? saidaItem;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    valorFocusNode?.dispose();
    valorTextController?.dispose();

    parcelaFocusNode?.dispose();
    parcelaTextController?.dispose();

    observacaoFocusNode?.dispose();
    observacaoTextController?.dispose();
  }
}
