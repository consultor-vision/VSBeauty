import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/d_evolucao/componentes_evolucao/b_editar_evolucao_copy/b_editar_evolucao_copy_widget.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:ui';
import 'evolucao_widget.dart' show EvolucaoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EvolucaoModel extends FlutterFlowModel<EvolucaoWidget> {
  ///  Local state fields for this page.

  int? idAgendamento;

  bool antesDepois = true;

  bool observacao = true;

  String? nomeProcedimentoSelecionado;

  int? idplano;

  String? cor;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown_Procediemtno widget.
  String? dropDownProcediemtnoValue;
  FormFieldController<String>? dropDownProcediemtnoValueController;
  // Stores action output result for [Backend Call - Query Rows] action in DropDown_Procediemtno widget.
  List<PlanosRow>? outPlano1;
  // Stores action output result for [Backend Call - Query Rows] action in DropDown_Procediemtno widget.
  List<UsuariosRow>? outProfissional;
  // Stores action output result for [Backend Call - Query Rows] action in DropDown_Procediemtno widget.
  List<AgendamentoRow>? outPlanoContagem;
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
