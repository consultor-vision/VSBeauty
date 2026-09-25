import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/conta_pagar/conta_pagar_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/dim_pagar/dim_categoria/novo/editar_categoria_nova/editar_categoria_nova_widget.dart';
import 'dart:ui';
import 'categoria_nova_widget.dart' show CategoriaNovaWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoriaNovaModel extends FlutterFlowModel<CategoriaNovaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Novo_Cadastroo widget.
  FocusNode? novoCadastrooFocusNode;
  TextEditingController? novoCadastrooTextController;
  String? Function(BuildContext, String?)? novoCadastrooTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    novoCadastrooFocusNode?.dispose();
    novoCadastrooTextController?.dispose();
  }
}
