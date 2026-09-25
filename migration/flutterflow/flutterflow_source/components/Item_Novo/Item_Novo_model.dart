import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/conta_pagar/conta_pagar_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/dim_pagar/dim_item_financeiro/novo/editar_item_nova/editar_item_nova_widget.dart';
import 'dart:ui';
import 'item_novo_widget.dart' show ItemNovoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemNovoModel extends FlutterFlowModel<ItemNovoWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Novo_Item widget.
  FocusNode? novoItemFocusNode;
  TextEditingController? novoItemTextController;
  String? Function(BuildContext, String?)? novoItemTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    novoItemFocusNode?.dispose();
    novoItemTextController?.dispose();
  }
}
