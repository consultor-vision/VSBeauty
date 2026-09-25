import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/d_evolucao/componentes_evolucao/d_cliente_evolucao/d_cliente_evolucao_widget.dart';
import '/vision_smart_beauty/g_geral/menu/configuracoes/configuracoes_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'menu_central_model.dart';
export 'menu_central_model.dart';

class MenuCentralWidget extends StatefulWidget {
  const MenuCentralWidget({super.key});

  @override
  State<MenuCentralWidget> createState() => _MenuCentralWidgetState();
}

class _MenuCentralWidgetState extends State<MenuCentralWidget> {
  late MenuCentralModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuCentralModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
      child: FutureBuilder<List<UsuariosRow>>(
        future: UsuariosTable().querySingleRow(
          queryFn: (q) => q.eqOrNull(
            'uid',
            currentUserUid,
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
          List<UsuariosRow> menuInferiorUsuariosRowList = snapshot.data!;

          final menuInferiorUsuariosRow = menuInferiorUsuariosRowList.isNotEmpty
              ? menuInferiorUsuariosRowList.first
              : null;

          return Material(
            color: Colors.transparent,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              width: 1400,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x9D14181B), Color(0xAD57636C)],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, 1),
                  end: AlignmentDirectional(0, -1),
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).tertiary,
                ),
              ),
              child: Visibility(
                visible: menuInferiorUsuariosRow?.acesso == true,
                child: FutureBuilder<List<CompanhiaRow>>(
                  future: CompanhiaTable().querySingleRow(
                    queryFn: (q) => q.eqOrNull(
                      'id',
                      menuInferiorUsuariosRow?.idCompanhia,
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
                    List<CompanhiaRow> containerCompanhiaRowList =
                        snapshot.data!;

                    final containerCompanhiaRow =
                        containerCompanhiaRowList.isNotEmpty
                            ? containerCompanhiaRowList.first
                            : null;

                    return Container(
                      decoration: BoxDecoration(),
                      child: Visibility(
                        visible: containerCompanhiaRow?.empresaAtiva == true,
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: ConfiguracoesWidget(),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Icon(
                                    Icons.menu_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 45,
                                        height: 45,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          menuInferiorUsuariosRow!.imagem!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        valueOrDefault<String>(
                                          menuInferiorUsuariosRow?.nome,
                                          'Nome',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 15)),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                      AgendaWidget.routeName,
                                      queryParameters: {
                                        'selectedDate': serializeParam(
                                          getCurrentTimestamp,
                                          ParamType.DateTime,
                                        ),
                                        'statusProcedimento': serializeParam(
                                          0,
                                          ParamType.int,
                                        ),
                                        'diaAtual': serializeParam(
                                          getCurrentTimestamp,
                                          ParamType.DateTime,
                                        ),
                                      }.withoutNulls,
                                    );

                                    FFAppState().botaoMenu = 'agenda';
                                    FFAppState().selectedClienteId = 1;
                                    safeSetState(() {});
                                  },
                                  text: 'Agenda',
                                  options: FFButtonOptions(
                                    width: 110,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: FFAppState().botaoMenu == 'agenda'
                                        ? FlutterFlowTheme.of(context).tertiary
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.interTight(
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 10,
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    FFAppState().botaoMenu = 'cadastro';
                                    safeSetState(() {});

                                    context.pushNamed(CadastroWidget.routeName);
                                  },
                                  text: 'Cadastro',
                                  options: FFButtonOptions(
                                    width: 110,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: FFAppState().botaoMenu == 'cadastro'
                                        ? FlutterFlowTheme.of(context).tertiary
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.interTight(
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 10,
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: DClienteEvolucaoWidget(
                                            urlCadastro: '',
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));

                                    FFAppState().botaoMenu = 'evolucao';
                                    safeSetState(() {});
                                  },
                                  text: 'EvoluÃ§Ã£o',
                                  options: FFButtonOptions(
                                    width: 110,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: FFAppState().botaoMenu == 'evolucao'
                                        ? FlutterFlowTheme.of(context).tertiary
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.interTight(
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 10,
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                if (menuInferiorUsuariosRow?.adm == true)
                                  FFButtonWidget(
                                    onPressed: () async {
                                      FFAppState().botaoMenu = 'gestao';
                                      safeSetState(() {});
                                      FFAppState().gestaoMenu = 'Colaborador';
                                      FFAppState().acesso = true;
                                      safeSetState(() {});

                                      context.pushNamed(GestaoWidget.routeName);
                                    },
                                    text: 'GestÃ£o',
                                    options: FFButtonOptions(
                                      width: 110,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: FFAppState().botaoMenu == 'gestao'
                                          ? FlutterFlowTheme.of(context)
                                              .tertiary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 10,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                if (menuInferiorUsuariosRow?.adm == true)
                                  FFButtonWidget(
                                    onPressed: () async {
                                      _model.ano =
                                          await VwAnalyticsFinanceiroMensalCompletoTable()
                                              .queryRows(
                                        queryFn: (q) => q.eqOrNull(
                                          'id_companhia',
                                          menuInferiorUsuariosRow?.idCompanhia,
                                        ),
                                      );
                                      FFAppState().botaoMenu = 'analytics';
                                      FFAppState().UpdateAnalytics = 'TOP_10';
                                      FFAppState().AnoAnalytics =
                                          _model.ano!.lastOrNull!.ano!;
                                      safeSetState(() {});

                                      context
                                          .pushNamed(AnalyticsWidget.routeName);

                                      safeSetState(() {});
                                    },
                                    text: 'Analytics',
                                    options: FFButtonOptions(
                                      width: 110,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color:
                                          FFAppState().botaoMenu == 'analytics'
                                              ? FlutterFlowTheme.of(context)
                                                  .tertiary
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 10,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                  tablet: false,
                                ))
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SvgPicture.asset(
                                      'assets/images/Logo_VSB2.svg',
                                      width: 200,
                                      height: 45,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
