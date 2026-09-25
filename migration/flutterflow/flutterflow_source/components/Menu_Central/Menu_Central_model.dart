import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/d_evolucao/componentes_evolucao/d_cliente_evolucao/d_cliente_evolucao_widget.dart';
import '/vision_smart_beauty/g_geral/menu/configuracoes/configuracoes_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'menu_central_widget.dart' show MenuCentralWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuCentralModel extends FlutterFlowModel<MenuCentralWidget> {
  ///  Local state fields for this component.

  String? botao;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in b_analytics widget.
  List<VwAnalyticsFinanceiroMensalCompletoRow>? ano;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
