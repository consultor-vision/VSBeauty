import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:ui';
import 'analytics_widget.dart' show AnalyticsWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AnalyticsModel extends FlutterFlowModel<AnalyticsWidget> {
  ///  Local state fields for this page.

  String? procedimentoTop;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown_Geral_Ano widget.
  int? dropDownGeralAnoValue;
  FormFieldController<int>? dropDownGeralAnoValueController;
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
