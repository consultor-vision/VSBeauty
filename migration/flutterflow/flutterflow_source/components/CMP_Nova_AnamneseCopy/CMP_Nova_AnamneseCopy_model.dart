import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'c_m_p_nova_anamnese_copy_widget.dart' show CMPNovaAnamneseCopyWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CMPNovaAnamneseCopyModel
    extends FlutterFlowModel<CMPNovaAnamneseCopyWidget> {
  ///  Local state fields for this component.

  String? editar;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Sim_Nao widget.
  String? simNaoValue;
  FormFieldController<String>? simNaoValueController;
  // State field(s) for Texto_Caso_Sil widget.
  FocusNode? textoCasoSilFocusNode;
  TextEditingController? textoCasoSilTextController;
  String? Function(BuildContext, String?)? textoCasoSilTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textoCasoSilFocusNode?.dispose();
    textoCasoSilTextController?.dispose();
  }
}
