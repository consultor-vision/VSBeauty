import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/d_gestao/descricao/descricao_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gestao/menu_gestao_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/a_colaborador/editar_colaborador/editar_colaborador_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/a_colaborador/novo_colaborador/novo_colaborador_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/b_procedimento/edicao_procedimento/edicao_procedimento_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/b_procedimento/novo_procedimento/novo_procedimento_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/c_anamnese/editar_pergunta/editar_pergunta_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/c_anamnese/nova_pergunta/nova_pergunta_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/conta_pagar/conta_pagar_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/editar_conta_pagar/editar_conta_pagar_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/e_contas_receber/descricao_recebimento/descricao_recebimento_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/e_contas_receber/editar_recebido/editar_recebido_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/editar_geral/a_editar_estoque/a_editar_estoque_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/novo_produto/a_novo_estoque/a_novo_estoque_widget.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:convert';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'gestao_widget.dart' show GestaoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GestaoModel extends FlutterFlowModel<GestaoWidget> {
  ///  Local state fields for this page.

  String? mesSelecionado;

  DateTime? inicioMes;

  DateTime? inicioProxMes;

  int? categoriaPagar;

  int? itemPagar;

  int? categoriaReceber;

  int? itemReceber;

  String? status;

  int? selectedYear;

  DateTime? inicioAno;

  DateTime? inicioProxAno;

  int? selectedYearPagar;

  DateTime? inicioAnoPagar;

  DateTime? inicioProxAnoPagar;

  int? filtroproduto;

  int? selecioneclienteID;

  bool? acesso = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (verificareatualizarcontas)] action in Gestao widget.
  ApiCallResponse? apiResultwvq;
  // State field(s) for Ano_Pagar widget.
  String? anoPagarValue;
  FormFieldController<String>? anoPagarValueController;
  // State field(s) for Mes_Pagar widget.
  String? mesPagarValue;
  FormFieldController<String>? mesPagarValueController;
  // State field(s) for Status_Pagar widget.
  String? statusPagarValue;
  FormFieldController<String>? statusPagarValueController;
  // State field(s) for Categoria_Pagar widget.
  String? categoriaPagarValue;
  FormFieldController<String>? categoriaPagarValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Categoria_Pagar widget.
  List<CategoriaRow>? opcaoCategoria;
  // State field(s) for Item_Pagar widget.
  String? itemPagarValue;
  FormFieldController<String>? itemPagarValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Item_Pagar widget.
  List<ItemFinanceiroRow>? opcaoItem;
  // State field(s) for Ano_Receber widget.
  String? anoReceberValue;
  FormFieldController<String>? anoReceberValueController;
  // State field(s) for Mes_Receber widget.
  String? mesReceberValue;
  FormFieldController<String>? mesReceberValueController;
  // State field(s) for Status_Receber widget.
  String? statusReceberValue;
  FormFieldController<String>? statusReceberValueController;
  // State field(s) for Categoria_Receber widget.
  int? categoriaReceberValue;
  FormFieldController<int>? categoriaReceberValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Categoria_Receber widget.
  List<ContaReceberRow>? saidaReceber;
  // Stores action output result for [Backend Call - Query Rows] action in Categoria_Receber widget.
  List<ProcedimentosRow>? saidaReceber2;
  // State field(s) for Item_Receber widget.
  String? itemReceberValue;
  FormFieldController<String>? itemReceberValueController;
  // Stores action output result for [Backend Call - Query Rows] action in Item_Receber widget.
  List<ClientesRow>? opcaoNome;
  // State field(s) for Nome_Colaborador widget.
  String? nomeColaboradorValue;
  FormFieldController<String>? nomeColaboradorValueController;
  // State field(s) for Acesso_Plataforma widget.
  bool? acessoPlataformaValue;
  FormFieldController<bool>? acessoPlataformaValueController;
  // State field(s) for Nome_Procedimento widget.
  String? nomeProcedimentoValue;
  FormFieldController<String>? nomeProcedimentoValueController;
  // State field(s) for Nome_Anamnese widget.
  String? nomeAnamneseValue;
  FormFieldController<String>? nomeAnamneseValueController;
  // State field(s) for Produto widget.
  int? produtoValue;
  FormFieldController<int>? produtoValueController;
  // Model for Menu_Central component.
  late MenuCentralModel menuCentralModel;

  @override
  void initState(BuildContext context) {
    menuCentralModel = createModel(context, () => MenuCentralModel());
  }

  @override
  void dispose() {
    menuCentralModel.dispose();
  }
}
