import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/alerta/alerta_falta_dados/alerta_falta_dados_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/calendario_contas_pagar/contas_pagar_emissao_d_p_popover/contas_pagar_emissao_d_p_popover_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/calendario_contas_pagar/contas_pagar_vencimento_d_p_popover/contas_pagar_vencimento_d_p_popover_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/dim_pagar/dim_categoria/novo/categoria_nova/categoria_nova_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/dim_pagar/dim_item_financeiro/novo/item_novo/item_novo_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'conta_pagar_widget.dart' show ContaPagarWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContaPagarModel extends FlutterFlowModel<ContaPagarWidget> {
  ///  Local state fields for this component.

  DateTime? dataEmissao;

  DateTime? dataPagamento;

  ///  State fields for stateful widgets in this component.

  // Model for Contas_Pagar_Emissao_DP_Popover component.
  late ContasPagarEmissaoDPPopoverModel contasPagarEmissaoDPPopoverModel;
  // Model for Contas_Pagar_Vencimento_DP_Popover component.
  late ContasPagarVencimentoDPPopoverModel contasPagarVencimentoDPPopoverModel;
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
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<CategoriaRow>? outCategoria;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<ItemFinanceiroRow>? outItem;

  @override
  void initState(BuildContext context) {
    contasPagarEmissaoDPPopoverModel =
        createModel(context, () => ContasPagarEmissaoDPPopoverModel());
    contasPagarVencimentoDPPopoverModel =
        createModel(context, () => ContasPagarVencimentoDPPopoverModel());
  }

  @override
  void dispose() {
    contasPagarEmissaoDPPopoverModel.dispose();
    contasPagarVencimentoDPPopoverModel.dispose();
    valorFocusNode?.dispose();
    valorTextController?.dispose();

    parcelaFocusNode?.dispose();
    parcelaTextController?.dispose();

    observacaoFocusNode?.dispose();
    observacaoTextController?.dispose();
  }
}
