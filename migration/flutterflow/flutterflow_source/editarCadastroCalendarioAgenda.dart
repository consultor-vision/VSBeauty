import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/b_agenda/componentes/calendario/agenda_d_p_popover/agenda_d_p_popover_widget.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'editar_cadastro_calendario_agenda_model.dart';
export 'editar_cadastro_calendario_agenda_model.dart';

class EditarCadastroCalendarioAgendaWidget extends StatefulWidget {
  const EditarCadastroCalendarioAgendaWidget({super.key});

  static String routeName = 'Editar_Cadastro_Calendario_Agenda';
  static String routePath = '/EditarCadastroDP';

  @override
  State<EditarCadastroCalendarioAgendaWidget> createState() =>
      _EditarCadastroCalendarioAgendaWidgetState();
}

class _EditarCadastroCalendarioAgendaWidgetState
    extends State<EditarCadastroCalendarioAgendaWidget> {
  late EditarCadastroCalendarioAgendaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditarCadastroCalendarioAgendaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: wrapWithModel(
              model: _model.agendaDPPopoverModel,
              updateCallback: () => safeSetState(() {}),
              child: AgendaDPPopoverWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
