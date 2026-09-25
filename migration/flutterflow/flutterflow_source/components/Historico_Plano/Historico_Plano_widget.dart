import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'historico_plano_model.dart';
export 'historico_plano_model.dart';

class HistoricoPlanoWidget extends StatefulWidget {
  const HistoricoPlanoWidget({
    super.key,
    this.urlCadastro,
    required this.idAgendamento,
    required this.idCliente,
    required this.idPlano,
  });

  final String? urlCadastro;
  final int? idAgendamento;
  final int? idCliente;
  final int? idPlano;

  @override
  State<HistoricoPlanoWidget> createState() => _HistoricoPlanoWidgetState();
}

class _HistoricoPlanoWidgetState extends State<HistoricoPlanoWidget> {
  late HistoricoPlanoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoricoPlanoModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.agendamento = await AgendamentoTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'id_cliente',
              widget!.idCliente,
            )
            .eqOrNull(
              'id_plano',
              widget!.idPlano,
            ),
      );
      _model.lsSessoes = _model.agendamento!.toList().cast<AgendamentoRow>();
      safeSetState(() {});
      _model.quantSess = _model.lsSessoes.length;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsets.all(15),
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
            List<UsuariosRow> cTNHistoricoUsuariosRowList = snapshot.data!;

            final cTNHistoricoUsuariosRow =
                cTNHistoricoUsuariosRowList.isNotEmpty
                    ? cTNHistoricoUsuariosRowList.first
                    : null;

            return Material(
              color: Colors.transparent,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: 1341.3,
                height: 470,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryText,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(
                        0,
                        2,
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).tertiary,
                  ),
                ),
                child: FutureBuilder<List<UsuariosRow>>(
                  future: UsuariosTable().querySingleRow(
                    queryFn: (q) => q.eqOrNull(
                      'id_companhia',
                      cTNHistoricoUsuariosRow?.idCompanhia,
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
                    List<UsuariosRow> colunaGeralUsuariosRowList =
                        snapshot.data!;

                    final colunaGeralUsuariosRow =
                        colunaGeralUsuariosRowList.isNotEmpty
                            ? colunaGeralUsuariosRowList.first
                            : null;

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 12, 0, 8),
                              child: Text(
                                'HistÃ³rico das SessÃµes',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).tertiary,
                        ),
                        Container(
                          width: 1330,
                          height: 405.83,
                          decoration: BoxDecoration(),
                          child: SingleChildScrollView(
                            primary: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              'Data da \nExecuÃ§Ã£o',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 300,
                                            height: 40,
                                            decoration: BoxDecoration(),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              'Nome do Procedimento',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            height: 40,
                                            decoration: BoxDecoration(),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              'ResponsÃ¡vel por',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              'Status do Procedimento',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                FutureBuilder<List<AgendamentoRow>>(
                                  future: AgendamentoTable().queryRows(
                                    queryFn: (q) => q
                                        .eqOrNull(
                                          'id_companhia',
                                          cTNHistoricoUsuariosRow?.idCompanhia,
                                        )
                                        .eqOrNull(
                                          'id_cliente',
                                          widget!.idCliente,
                                        )
                                        .eqOrNull(
                                          'id_plano',
                                          widget!.idPlano,
                                        )
                                        .eqOrNull(
                                          'status_procedimento',
                                          'ConcluÃ­do',
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
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
                                            size: 50,
                                          ),
                                        ),
                                      );
                                    }
                                    List<AgendamentoRow>
                                        listViewAgendamentoRowList =
                                        snapshot.data!;

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          listViewAgendamentoRowList.length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewAgendamentoRow =
                                            listViewAgendamentoRowList[
                                                listViewIndex];
                                        return SingleChildScrollView(
                                          primary: false,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 40,
                                                      decoration:
                                                          BoxDecoration(),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                              "dd/MM/yyyy",
                                                              listViewAgendamentoRow
                                                                  .dataInicio,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                            'ExecuÃ§Ã£o',
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    FutureBuilder<
                                                        List<PlanosRow>>(
                                                      future: PlanosTable()
                                                          .querySingleRow(
                                                        queryFn: (q) => q
                                                            .eqOrNull(
                                                              'id_companhia',
                                                              cTNHistoricoUsuariosRow
                                                                  ?.idCompanhia,
                                                            )
                                                            .eqOrNull(
                                                              'id',
                                                              listViewAgendamentoRow
                                                                  .idPlano,
                                                            ),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 50,
                                                              height: 50,
                                                              child:
                                                                  SpinKitFadingFour(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                size: 50,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<PlanosRow>
                                                            ctnProcedimentoPlanosRowList =
                                                            snapshot.data!;

                                                        final ctnProcedimentoPlanosRow =
                                                            ctnProcedimentoPlanosRowList
                                                                    .isNotEmpty
                                                                ? ctnProcedimentoPlanosRowList
                                                                    .first
                                                                : null;

                                                        return Container(
                                                          width: 300,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0, 0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              ctnProcedimentoPlanosRow
                                                                  ?.nomePlano,
                                                              'Procedimento',
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    FutureBuilder<
                                                        List<UsuariosRow>>(
                                                      future: UsuariosTable()
                                                          .querySingleRow(
                                                        queryFn: (q) => q
                                                            .eqOrNull(
                                                              'id_companhia',
                                                              cTNHistoricoUsuariosRow
                                                                  ?.idCompanhia,
                                                            )
                                                            .eqOrNull(
                                                              'id',
                                                              listViewAgendamentoRow
                                                                  .idProfissional,
                                                            ),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 50,
                                                              height: 50,
                                                              child:
                                                                  SpinKitFadingFour(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                size: 50,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<UsuariosRow>
                                                            ctnResponsavelUsuariosRowList =
                                                            snapshot.data!;

                                                        final ctnResponsavelUsuariosRow =
                                                            ctnResponsavelUsuariosRowList
                                                                    .isNotEmpty
                                                                ? ctnResponsavelUsuariosRowList
                                                                    .first
                                                                : null;

                                                        return Container(
                                                          width: 200,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0, 0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              ctnResponsavelUsuariosRow
                                                                  ?.nome,
                                                              'Nome',
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 40,
                                                      decoration:
                                                          BoxDecoration(),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          listViewAgendamentoRow
                                                              .statusProcedimento,
                                                          'Status',
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
