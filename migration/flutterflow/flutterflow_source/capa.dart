import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'capa_model.dart';
export 'capa_model.dart';

class CapaWidget extends StatefulWidget {
  const CapaWidget({
    super.key,
    this.selectedDate,
    this.diaAtual,
  });

  final DateTime? selectedDate;
  final DateTime? diaAtual;

  static String routeName = 'Capa';
  static String routePath = '/Seja_Bem_Vindo';

  @override
  State<CapaWidget> createState() => _CapaWidgetState();
}

class _CapaWidgetState extends State<CapaWidget> {
  late CapaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CapaModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (RootPageContext.isInactiveRootPage(context)) {
        return;
      }
      _model.video = 'NÃO';
      safeSetState(() {});
      await Future.delayed(
        Duration(
          milliseconds: 7001,
        ),
      );
      _model.video = 'SIM';
      safeSetState(() {});
      _model.dataInicio = functions.criarDataHora(getCurrentTimestamp, 00, 00);
      _model.dataFim = functions.criarDataHora(getCurrentTimestamp, 23, 59);
      _model.calendario = widget!.selectedDate;
      _model.selectedDate = getCurrentTimestamp;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UsuariosRow>>(
      future: UsuariosTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'uid',
          currentUserUid,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryText,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: SpinKitFadingFour(
                  color: FlutterFlowTheme.of(context).tertiary,
                  size: 50,
                ),
              ),
            ),
          );
        }
        List<UsuariosRow> capaUsuariosRowList = snapshot.data!;

        final capaUsuariosRow =
            capaUsuariosRowList.isNotEmpty ? capaUsuariosRowList.first : null;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryText,
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                if ((_model.video == 'NÃO') &&
                    responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(),
                    child: FlutterFlowVideoPlayer(
                      path:
                          'https://ijcwsuibamqdlksgujlp.supabase.co/storage/v1/object/public/vsbgaleria/logos/vinheta_Abertura.mp4',
                      videoType: VideoType.network,
                      autoPlay: true,
                      looping: false,
                      showControls: false,
                      allowFullScreen: true,
                      allowPlaybackSpeedMenu: false,
                      pauseOnNavigate: false,
                    ),
                  ),
                if ((_model.video == 'SIM') &&
                    responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                  FutureBuilder<List<CompanhiaRow>>(
                    future: CompanhiaTable().querySingleRow(
                      queryFn: (q) => q.eqOrNull(
                        'id',
                        capaUsuariosRow?.idCompanhia,
                      ),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: SpinKitFadingFour(
                              color: FlutterFlowTheme.of(context).tertiary,
                              size: 50,
                            ),
                          ),
                        );
                      }
                      List<CompanhiaRow> visionCompanhiaRowList =
                          snapshot.data!;

                      final visionCompanhiaRow =
                          visionCompanhiaRowList.isNotEmpty
                              ? visionCompanhiaRowList.first
                              : null;

                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  width: 1400,
                                  height: 825,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.network(
                                        '',
                                      ).image,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0x5314181B),
                                        Color(0xAD57636C)
                                      ],
                                      stops: [0, 1],
                                      begin: AlignmentDirectional(-0.98, -1),
                                      end: AlignmentDirectional(0.98, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SvgPicture.asset(
                                        'assets/images/Logo_VSB2.svg',
                                        width: 200,
                                        height: 141.9,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (capaUsuariosRow?.acesso == true)
                              wrapWithModel(
                                model: _model.menuCentralModel,
                                updateCallback: () => safeSetState(() {}),
                                child: MenuCentralWidget(),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
