import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/b_agenda/componentes/calendario/agenda_d_p_popover/agenda_d_p_popover_widget.dart';
import 'editar_cadastro_calendario_agenda_widget.dart'
    show EditarCadastroCalendarioAgendaWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditarCadastroCalendarioAgendaModel
    extends FlutterFlowModel<EditarCadastroCalendarioAgendaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Agenda_DP_Popover component.
  late AgendaDPPopoverModel agendaDPPopoverModel;

  @override
  void initState(BuildContext context) {
    agendaDPPopoverModel = createModel(context, () => AgendaDPPopoverModel());
  }

  @override
  void dispose() {
    agendaDPPopoverModel.dispose();
  }
}
