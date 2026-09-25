import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'capa_widget.dart' show CapaWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CapaModel extends FlutterFlowModel<CapaWidget> {
  ///  Local state fields for this page.

  DateTime? dataInicio;

  DateTime? dataFim;

  DateTime? calendario;

  DateTime? selectedDate;

  bool mostrarAgendamentos = false;

  String? video;

  ///  State fields for stateful widgets in this page.

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
