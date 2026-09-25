import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/vision_smart_beauty/d_evolucao/componentes_evolucao/c_editar_produtos/c_editar_produtos_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/novo_produto/b_novo_produto/b_novo_produto_widget.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'b_editar_evolucao_model.dart';
export 'b_editar_evolucao_model.dart';

class BEditarEvolucaoWidget extends StatefulWidget {
  const BEditarEvolucaoWidget({
    super.key,
    required this.dataagendamento,
    required this.horarioagendamento,
    required this.idclienteagendamento,
    required this.idagendamento,
    required this.idPlanmoAgendamento,
    required this.nomePlano,
  });

  final DateTime? dataagendamento;
  final DateTime? horarioagendamento;
  final int? idclienteagendamento;
  final int? idagendamento;
  final int? idPlanmoAgendamento;
  final String? nomePlano;

  @override
  State<BEditarEvolucaoWidget> createState() => _BEditarEvolucaoWidgetState();
}

class _BEditarEvolucaoWidgetState extends State<BEditarEvolucaoWidget> {
  late BEditarEvolucaoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BEditarEvolucaoModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.fotos = await EvolucaoClienteTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'id_agendamento',
          widget!.idagendamento,
        ),
      );
    });

    _model.observcaoFocusNode ??= FocusNode();

    _model.tipoEmbalagemTextController ??= TextEditingController();
    _model.tipoEmbalagemFocusNode ??= FocusNode();

    _model.quantidadeTextController ??= TextEditingController();
    _model.quantidadeFocusNode ??= FocusNode();

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
            List<UsuariosRow> cTNDadosUsuariosRowList = snapshot.data!;

            final cTNDadosUsuariosRow = cTNDadosUsuariosRowList.isNotEmpty
                ? cTNDadosUsuariosRowList.first
                : null;

            return Material(
              color: Colors.transparent,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: 871.5,
                height: 900,
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
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).tertiary,
                  ),
                ),
                child: FutureBuilder<List<CompanhiaRow>>(
                  future: CompanhiaTable().querySingleRow(
                    queryFn: (q) => q.eqOrNull(
                      'id',
                      cTNDadosUsuariosRow?.idCompanhia,
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
                    List<CompanhiaRow> colunaGeralCompanhiaRowList =
                        snapshot.data!;

                    final colunaGeralCompanhiaRow =
                        colunaGeralCompanhiaRowList.isNotEmpty
                            ? colunaGeralCompanhiaRowList.first
                            : null;

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FutureBuilder<List<VwEstoqueEvolucaoRow>>(
                          future: VwEstoqueEvolucaoTable().querySingleRow(
                            queryFn: (q) => q.eqOrNull(
                              'id_companhia',
                              cTNDadosUsuariosRow?.idCompanhia,
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
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    size: 50,
                                  ),
                                ),
                              );
                            }
                            List<VwEstoqueEvolucaoRow>
                                cTNCabecalhoVwEstoqueEvolucaoRowList =
                                snapshot.data!;

                            final cTNCabecalhoVwEstoqueEvolucaoRow =
                                cTNCabecalhoVwEstoqueEvolucaoRowList.isNotEmpty
                                    ? cTNCabecalhoVwEstoqueEvolucaoRowList.first
                                    : null;

                            return Container(
                              decoration: BoxDecoration(),
                              child: FutureBuilder<List<ProdutosRow>>(
                                future: ProdutosTable().querySingleRow(
                                  queryFn: (q) => q.eqOrNull(
                                    'id_companhia',
                                    cTNDadosUsuariosRow?.idCompanhia,
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
                                  List<ProdutosRow>
                                      linhaCabecalhoProdutosRowList =
                                      snapshot.data!;

                                  final linhaCabecalhoProdutosRow =
                                      linhaCabecalhoProdutosRowList.isNotEmpty
                                          ? linhaCabecalhoProdutosRowList.first
                                          : null;

                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 12, 0, 8),
                                        child: Text(
                                          'EdiÃ§Ã£o da EvoluÃ§Ã£o do Cliente',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                fontSize: 16,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 5, 0),
                                        child: FutureBuilder<List<EstoqueRow>>(
                                          future: EstoqueTable().querySingleRow(
                                            queryFn: (q) => q.eqOrNull(
                                              'id_companhia',
                                              cTNDadosUsuariosRow?.idCompanhia,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiary,
                                                    size: 50,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<EstoqueRow>
                                                iconEstoqueRowList =
                                                snapshot.data!;

                                            final iconEstoqueRow =
                                                iconEstoqueRowList.isNotEmpty
                                                    ? iconEstoqueRowList.first
                                                    : null;

                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.apiResultvws =
                                                    await RollbackEstoqueCall
                                                        .call(
                                                  pIdAgendamento:
                                                      widget!.idagendamento,
                                                );

                                                if ((_model.apiResultvws
                                                        ?.succeeded ??
                                                    true)) {
                                                  _model.fechar =
                                                      await EstoqueEvolucaoTable()
                                                          .queryRows(
                                                    queryFn: (q) => q
                                                        .eqOrNull(
                                                          'id_agendamento',
                                                          widget!.idagendamento,
                                                        )
                                                        .eqOrNull(
                                                          'id_produto',
                                                          cTNCabecalhoVwEstoqueEvolucaoRow
                                                              ?.idProduto,
                                                        )
                                                        .eqOrNull(
                                                          'quantidade',
                                                          cTNCabecalhoVwEstoqueEvolucaoRow
                                                              ?.quantidadeUtilizada,
                                                        )
                                                        .eqOrNull(
                                                          'tipo_movimentacao',
                                                          'saida',
                                                        ),
                                                  );
                                                  Navigator.pop(context);
                                                }

                                                safeSetState(() {});
                                              },
                                              child: Icon(
                                                Icons.close_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                size: 24,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        Divider(
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).tertiary,
                        ),
                        Container(
                          width: 1100,
                          height: 919.67,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                            child: FutureBuilder<List<PlanosRow>>(
                              future: PlanosTable().querySingleRow(
                                queryFn: (q) => q
                                    .eqOrNull(
                                      'id_companhia',
                                      cTNDadosUsuariosRow?.idCompanhia,
                                    )
                                    .eqOrNull(
                                      'id',
                                      widget!.idPlanmoAgendamento,
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
                                List<PlanosRow> columnPlanosRowList =
                                    snapshot.data!;

                                final columnPlanosRow =
                                    columnPlanosRowList.isNotEmpty
                                        ? columnPlanosRowList.first
                                        : null;

                                return SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 10),
                                        child: FutureBuilder<List<ClientesRow>>(
                                          future:
                                              ClientesTable().querySingleRow(
                                            queryFn: (q) => q
                                                .eqOrNull(
                                                  'id_companhia',
                                                  cTNDadosUsuariosRow
                                                      ?.idCompanhia,
                                                )
                                                .eqOrNull(
                                                  'id',
                                                  widget!.idclienteagendamento,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiary,
                                                    size: 50,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<ClientesRow>
                                                ctnInformacoesClientesRowList =
                                                snapshot.data!;

                                            final ctnInformacoesClientesRow =
                                                ctnInformacoesClientesRowList
                                                        .isNotEmpty
                                                    ? ctnInformacoesClientesRowList
                                                        .first
                                                    : null;

                                            return Container(
                                              width: 1100,
                                              decoration: BoxDecoration(),
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: FutureBuilder<
                                                  List<ProcedimentosRow>>(
                                                future: ProcedimentosTable()
                                                    .querySingleRow(
                                                  queryFn: (q) => q
                                                      .eqOrNull(
                                                        'id_companhia',
                                                        cTNDadosUsuariosRow
                                                            ?.idCompanhia,
                                                      )
                                                      .eqOrNull(
                                                        'id',
                                                        columnPlanosRow
                                                            ?.idProcedimento,
                                                      ),
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child:
                                                            SpinKitFadingFour(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                          size: 50,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<ProcedimentosRow>
                                                      informacoesProcedimentosRowList =
                                                      snapshot.data!;

                                                  final informacoesProcedimentosRow =
                                                      informacoesProcedimentosRowList
                                                              .isNotEmpty
                                                          ? informacoesProcedimentosRowList
                                                              .first
                                                          : null;

                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Nome: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                ctnInformacoesClientesRow
                                                                    ?.nome,
                                                                'Nome',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' | Data de Nascimento: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                dateTimeFormat(
                                                                  "d/M/y",
                                                                  ctnInformacoesClientesRow
                                                                      ?.dataNascimento,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                                'Data de Nascimento',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text: ' |  CPF: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                ctnInformacoesClientesRow
                                                                    ?.cpf,
                                                                'CPF',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                fontSize: 16,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: 'Data: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  dateTimeFormat(
                                                                "dd/MM/yyyy",
                                                                widget!
                                                                    .dataagendamento,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' | HorÃ¡rio: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  dateTimeFormat(
                                                                "Hm",
                                                                widget!
                                                                    .horarioagendamento,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' |  Planos: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                widget!
                                                                    .nomePlano,
                                                                'Nome',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                fontSize: 16,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 8)),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          if (FFAppState().telaEvolucao ==
                                              'Atender')
                                            Container(
                                              height: 770,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  FutureBuilder<
                                                      List<AgendamentoRow>>(
                                                    future: AgendamentoTable()
                                                        .querySingleRow(
                                                      queryFn: (q) =>
                                                          q.eqOrNull(
                                                        'id_companhia',
                                                        cTNDadosUsuariosRow
                                                            ?.idCompanhia,
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                              size: 50,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<AgendamentoRow>
                                                          cTNFotosAgendamentoRowList =
                                                          snapshot.data!;

                                                      final cTNFotosAgendamentoRow =
                                                          cTNFotosAgendamentoRowList
                                                                  .isNotEmpty
                                                              ? cTNFotosAgendamentoRowList
                                                                  .first
                                                              : null;

                                                      return Container(
                                                        height: 250,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: FutureBuilder<
                                                            List<
                                                                EvolucaoClienteRow>>(
                                                          future:
                                                              EvolucaoClienteTable()
                                                                  .querySingleRow(
                                                            queryFn: (q) =>
                                                                q.eqOrNull(
                                                              'id_agendamento',
                                                              widget!
                                                                  .idagendamento,
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
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
                                                            List<EvolucaoClienteRow>
                                                                linhaFotosEvolucaoClienteRowList =
                                                                snapshot.data!;

                                                            final linhaFotosEvolucaoClienteRow =
                                                                linhaFotosEvolucaoClienteRowList
                                                                        .isNotEmpty
                                                                    ? linhaFotosEvolucaoClienteRowList
                                                                        .first
                                                                    : null;

                                                            return Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      'Antes',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            fontSize:
                                                                                16,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          150,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          linhaFotosEvolucaoClienteRow
                                                                              ?.antes,
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vision-smart-beauty-l7vxwr/assets/07xf7era71f4/perfil_ok_ok.png',
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          final selectedMedia =
                                                                              await selectMediaWithSourceBottomSheet(
                                                                            context:
                                                                                context,
                                                                            storageFolderPath:
                                                                                'antes',
                                                                            allowPhoto:
                                                                                true,
                                                                          );
                                                                          if (selectedMedia != null &&
                                                                              selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                            safeSetState(() =>
                                                                                _model.isDataUploading_editarantes2 = true);
                                                                            var selectedUploadedFiles =
                                                                                <FFUploadedFile>[];

                                                                            var downloadUrls =
                                                                                <String>[];
                                                                            try {
                                                                              selectedUploadedFiles = selectedMedia
                                                                                  .map((m) => FFUploadedFile(
                                                                                        name: m.storagePath.split('/').last,
                                                                                        bytes: m.bytes,
                                                                                        height: m.dimensions?.height,
                                                                                        width: m.dimensions?.width,
                                                                                        blurHash: m.blurHash,
                                                                                        originalFilename: m.originalFilename,
                                                                                      ))
                                                                                  .toList();

                                                                              downloadUrls = await uploadSupabaseStorageFiles(
                                                                                bucketName: 'vsbgaleria',
                                                                                selectedFiles: selectedMedia,
                                                                              );
                                                                            } finally {
                                                                              _model.isDataUploading_editarantes2 = false;
                                                                            }
                                                                            if (selectedUploadedFiles.length == selectedMedia.length &&
                                                                                downloadUrls.length == selectedMedia.length) {
                                                                              safeSetState(() {
                                                                                _model.uploadedLocalFile_editarantes2 = selectedUploadedFiles.first;
                                                                                _model.uploadedFileUrl_editarantes2 = downloadUrls.first;
                                                                              });
                                                                            } else {
                                                                              safeSetState(() {});
                                                                              return;
                                                                            }
                                                                          }

                                                                          _model.antesEvolucao =
                                                                              _model.uploadedFileUrl_editarantes2;
                                                                          safeSetState(
                                                                              () {});
                                                                          await EvolucaoClienteTable()
                                                                              .update(
                                                                            data: {
                                                                              'antes': _model.antesEvolucao,
                                                                            },
                                                                            matchingRows: (rows) =>
                                                                                rows.eqOrNull(
                                                                              'id_agendamento',
                                                                              widget!.idagendamento,
                                                                            ),
                                                                          );
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'Foto Atualizada com Sucesso!',
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                              ),
                                                                              duration: Duration(milliseconds: 4000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).tertiary,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              Image.network(
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vision-smart-beauty-l7vxwr/assets/hswlxpa4jllv/upload-icon-32.png',
                                                                            width:
                                                                                70,
                                                                            height:
                                                                                70,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      'Depois',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            fontSize:
                                                                                16,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          150,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          linhaFotosEvolucaoClienteRow
                                                                              ?.depois,
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vision-smart-beauty-l7vxwr/assets/07xf7era71f4/perfil_ok_ok.png',
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          final selectedMedia =
                                                                              await selectMediaWithSourceBottomSheet(
                                                                            context:
                                                                                context,
                                                                            storageFolderPath:
                                                                                'depois',
                                                                            allowPhoto:
                                                                                true,
                                                                          );
                                                                          if (selectedMedia != null &&
                                                                              selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                            safeSetState(() =>
                                                                                _model.isDataUploading_editardepois2 = true);
                                                                            var selectedUploadedFiles =
                                                                                <FFUploadedFile>[];

                                                                            var downloadUrls =
                                                                                <String>[];
                                                                            try {
                                                                              selectedUploadedFiles = selectedMedia
                                                                                  .map((m) => FFUploadedFile(
                                                                                        name: m.storagePath.split('/').last,
                                                                                        bytes: m.bytes,
                                                                                        height: m.dimensions?.height,
                                                                                        width: m.dimensions?.width,
                                                                                        blurHash: m.blurHash,
                                                                                        originalFilename: m.originalFilename,
                                                                                      ))
                                                                                  .toList();

                                                                              downloadUrls = await uploadSupabaseStorageFiles(
                                                                                bucketName: 'vsbgaleria',
                                                                                selectedFiles: selectedMedia,
                                                                              );
                                                                            } finally {
                                                                              _model.isDataUploading_editardepois2 = false;
                                                                            }
                                                                            if (selectedUploadedFiles.length == selectedMedia.length &&
                                                                                downloadUrls.length == selectedMedia.length) {
                                                                              safeSetState(() {
                                                                                _model.uploadedLocalFile_editardepois2 = selectedUploadedFiles.first;
                                                                                _model.uploadedFileUrl_editardepois2 = downloadUrls.first;
                                                                              });
                                                                            } else {
                                                                              safeSetState(() {});
                                                                              return;
                                                                            }
                                                                          }

                                                                          _model.depoisEvolucao =
                                                                              _model.uploadedFileUrl_editardepois2;
                                                                          safeSetState(
                                                                              () {});
                                                                          await EvolucaoClienteTable()
                                                                              .update(
                                                                            data: {
                                                                              'depois': _model.depoisEvolucao,
                                                                            },
                                                                            matchingRows: (rows) =>
                                                                                rows.eqOrNull(
                                                                              'id_agendamento',
                                                                              widget!.idagendamento,
                                                                            ),
                                                                          );
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'Foto Atualizada com Sucesso!',
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                              ),
                                                                              duration: Duration(milliseconds: 4000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).tertiary,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              Image.network(
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vision-smart-beauty-l7vxwr/assets/hswlxpa4jllv/upload-icon-32.png',
                                                                            width:
                                                                                70,
                                                                            height:
                                                                                70,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Container(
                                                    width: 1100,
                                                    height: 180,
                                                    decoration: BoxDecoration(),
                                                    child: FutureBuilder<
                                                        List<
                                                            EvolucaoClienteRow>>(
                                                      future:
                                                          EvolucaoClienteTable()
                                                              .querySingleRow(
                                                        queryFn: (q) =>
                                                            q.eqOrNull(
                                                          'id_agendamento',
                                                          widget!.idagendamento,
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
                                                        List<EvolucaoClienteRow>
                                                            observcaoEvolucaoClienteRowList =
                                                            snapshot.data!;

                                                        final observcaoEvolucaoClienteRow =
                                                            observcaoEvolucaoClienteRowList
                                                                    .isNotEmpty
                                                                ? observcaoEvolucaoClienteRowList
                                                                    .first
                                                                : null;

                                                        return Container(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                    .observcaoTextController ??=
                                                                TextEditingController(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                observcaoEvolucaoClienteRow
                                                                    ?.observacao,
                                                                'ObservaÃ§Ã£o',
                                                              ),
                                                            ),
                                                            focusNode: _model
                                                                .observcaoFocusNode,
                                                            autofocus: true,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'ObservaÃ§Ã£o',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            16,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0x7FF9CF58),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .warning,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0x00FFFFFF),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                            maxLines: 10,
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning,
                                                            validator: _model
                                                                .observcaoTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1, 0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        FFAppState()
                                                            .PuxarProduto = '';
                                                        safeSetState(() {});
                                                        FFAppState()
                                                                .telaEvolucao =
                                                            'Novo';
                                                        safeSetState(() {});
                                                      },
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 10,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Container(
                                                          width: 180,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .success,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Icon(
                                                                  Icons
                                                                      .add_circle_outline_outlined,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Produto Usado',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      fontSize:
                                                                          16,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 5)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 1100,
                                                    height: 220,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, -1),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: 200,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Produtos',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            fontSize:
                                                                                16,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 200,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Sistema de Medidas',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            fontSize:
                                                                                16,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 200,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Quantidade',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            fontSize:
                                                                                16,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 200,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Excluir',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            fontSize:
                                                                                16,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 200,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child:
                                                                SingleChildScrollView(
                                                              primary: false,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  FutureBuilder<
                                                                      List<
                                                                          VwEstoqueEvolucaoRow>>(
                                                                    future: VwEstoqueEvolucaoTable()
                                                                        .queryRows(
                                                                      queryFn: (q) => q
                                                                          .eqOrNull(
                                                                            'id_companhia',
                                                                            cTNDadosUsuariosRow?.idCompanhia,
                                                                          )
                                                                          .eqOrNull(
                                                                            'id_produto',
                                                                            _model.filtroproduto,
                                                                          )
                                                                          .gtOrNull(
                                                                            'quantidade_utilizada',
                                                                            0,
                                                                          )
                                                                          .eqOrNull(
                                                                            'id_agendamento',
                                                                            widget!.idagendamento,
                                                                          )
                                                                          .order('id_produto', ascending: true),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                SpinKitFadingFour(
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              size: 50,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<VwEstoqueEvolucaoRow>
                                                                          listViewVwEstoqueEvolucaoRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return ListView
                                                                          .separated(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        primary:
                                                                            false,
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        itemCount:
                                                                            listViewVwEstoqueEvolucaoRowList.length,
                                                                        separatorBuilder:
                                                                            (_, __) =>
                                                                                SizedBox(height: 10),
                                                                        itemBuilder:
                                                                            (context,
                                                                                listViewIndex) {
                                                                          final listViewVwEstoqueEvolucaoRow =
                                                                              listViewVwEstoqueEvolucaoRowList[listViewIndex];
                                                                          return Container(
                                                                            height:
                                                                                40,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                FutureBuilder<List<ProdutosRow>>(
                                                                              future: ProdutosTable().querySingleRow(
                                                                                queryFn: (q) => q
                                                                                    .eqOrNull(
                                                                                      'id_companhia',
                                                                                      listViewVwEstoqueEvolucaoRow.idCompanhia,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'id',
                                                                                      listViewVwEstoqueEvolucaoRow.idProduto,
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
                                                                                List<ProdutosRow> linhaGeralProdutosRowList = snapshot.data!;

                                                                                final linhaGeralProdutosRow = linhaGeralProdutosRowList.isNotEmpty ? linhaGeralProdutosRowList.first : null;

                                                                                return Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 200,
                                                                                      decoration: BoxDecoration(),
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          linhaGeralProdutosRow?.produtos,
                                                                                          'Produto',
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              fontSize: 14,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 200,
                                                                                      decoration: BoxDecoration(),
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          listViewVwEstoqueEvolucaoRow.tipoEmbalagem,
                                                                                          'Tipo de Embalagem',
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              fontSize: 14,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 200,
                                                                                      decoration: BoxDecoration(),
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          listViewVwEstoqueEvolucaoRow.quantidadeUtilizada.toString(),
                                                                                          'Quantidade',
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              fontSize: 14,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    FutureBuilder<List<EstoqueRow>>(
                                                                                      future: EstoqueTable().querySingleRow(
                                                                                        queryFn: (q) => q
                                                                                            .eqOrNull(
                                                                                              'id_companhia',
                                                                                              linhaGeralProdutosRow?.idCompanhia,
                                                                                            )
                                                                                            .eqOrNull(
                                                                                              'id_produto',
                                                                                              listViewVwEstoqueEvolucaoRow.idProduto,
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
                                                                                        List<EstoqueRow> cTNBotaoEstoqueRowList = snapshot.data!;

                                                                                        final cTNBotaoEstoqueRow = cTNBotaoEstoqueRowList.isNotEmpty ? cTNBotaoEstoqueRowList.first : null;

                                                                                        return Container(
                                                                                          width: 200,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(0, 0),
                                                                                            child: FlutterFlowIconButton(
                                                                                              borderRadius: 20,
                                                                                              buttonSize: 40,
                                                                                              fillColor: FlutterFlowTheme.of(context).error,
                                                                                              icon: Icon(
                                                                                                Icons.restore_from_trash,
                                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                                size: 25,
                                                                                              ),
                                                                                              onPressed: () async {
                                                                                                await showModalBottomSheet(
                                                                                                  isScrollControlled: true,
                                                                                                  backgroundColor: Colors.transparent,
                                                                                                  enableDrag: false,
                                                                                                  context: context,
                                                                                                  builder: (context) {
                                                                                                    return Padding(
                                                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                                                      child: CEditarProdutosWidget(
                                                                                                        idEstoque: listViewVwEstoqueEvolucaoRow.idProduto!,
                                                                                                        produtoId: listViewVwEstoqueEvolucaoRow.idProduto!,
                                                                                                        tipoEmbalagem: linhaGeralProdutosRow!.tipoEmbalagem!,
                                                                                                        quantidade: listViewVwEstoqueEvolucaoRow.quantidadeUtilizada!,
                                                                                                        nomeProduto: linhaGeralProdutosRow!.produtos!,
                                                                                                        idAgendamento: widget!.idagendamento!,
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ).then((value) => safeSetState(() {}));
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
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
                                                      ),
                                                    ),
                                                  ),
                                                  FutureBuilder<
                                                      List<EvolucaoClienteRow>>(
                                                    future:
                                                        EvolucaoClienteTable()
                                                            .querySingleRow(
                                                      queryFn: (q) => q,
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                              size: 50,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<EvolucaoClienteRow>
                                                          cTNBotaoEvolucaoClienteRowList =
                                                          snapshot.data!;

                                                      final cTNBotaoEvolucaoClienteRow =
                                                          cTNBotaoEvolucaoClienteRowList
                                                                  .isNotEmpty
                                                              ? cTNBotaoEvolucaoClienteRowList
                                                                  .first
                                                              : null;

                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 10),
                                                          child: FutureBuilder<
                                                              List<
                                                                  AgendamentoRow>>(
                                                            future: AgendamentoTable()
                                                                .querySingleRow(
                                                              queryFn: (q) =>
                                                                  q.isFilter(
                                                                'id',
                                                                true,
                                                              ),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
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
                                                              List<AgendamentoRow>
                                                                  buttonAgendamentoRowList =
                                                                  snapshot
                                                                      .data!;

                                                              final buttonAgendamentoRow =
                                                                  buttonAgendamentoRowList
                                                                          .isNotEmpty
                                                                      ? buttonAgendamentoRowList
                                                                          .first
                                                                      : null;

                                                              return FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  await EvolucaoClienteTable()
                                                                      .update(
                                                                    data: {
                                                                      'observacao': _model
                                                                          .observcaoTextController
                                                                          .text,
                                                                      'alterado_por':
                                                                          cTNDadosUsuariosRow
                                                                              ?.id,
                                                                      'data_alteracao':
                                                                          supaSerialize<DateTime>(
                                                                              getCurrentTimestamp),
                                                                    },
                                                                    matchingRows:
                                                                        (rows) =>
                                                                            rows.eqOrNull(
                                                                      'id_agendamento',
                                                                      widget!
                                                                          .idagendamento,
                                                                    ),
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'EvoluÃ§Ã£o do cliente editada com sucesso!',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .tertiary,
                                                                    ),
                                                                  );
                                                                },
                                                                text: 'Salvar',
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: 150,
                                                                  height: 40,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          16,
                                                                          0),
                                                                  iconPadding:
                                                                      EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                  color: Color(
                                                                      0xA8F9CF58),
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .interTight(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                  elevation: 10,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ].divide(SizedBox(height: 10)),
                                              ),
                                            ),
                                          if (FFAppState().telaEvolucao ==
                                              'Novo')
                                            FutureBuilder<List<UsuariosRow>>(
                                              future: UsuariosTable()
                                                  .querySingleRow(
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        size: 50,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<UsuariosRow>
                                                    cTNNovoProdutoUsuariosRowList =
                                                    snapshot.data!;

                                                final cTNNovoProdutoUsuariosRow =
                                                    cTNNovoProdutoUsuariosRowList
                                                            .isNotEmpty
                                                        ? cTNNovoProdutoUsuariosRowList
                                                            .first
                                                        : null;

                                                return Material(
                                                  color: Colors.transparent,
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Container(
                                                    width: 1000,
                                                    height: 235,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                              Color(0x33000000),
                                                          offset: Offset(
                                                            0,
                                                            2,
                                                          ),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12,
                                                                          12,
                                                                          0,
                                                                          8),
                                                              child: Text(
                                                                'Novo Estoque',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      fontSize:
                                                                          16,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          5,
                                                                          0),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  FFAppState()
                                                                          .telaEvolucao =
                                                                      'Atender';
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .close_outlined,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          thickness: 1,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                        ),
                                                        FutureBuilder<
                                                            List<EstoqueRow>>(
                                                          future: EstoqueTable()
                                                              .queryRows(
                                                            queryFn: (q) =>
                                                                q.eqOrNull(
                                                              'id_companhia',
                                                              cTNNovoProdutoUsuariosRow
                                                                  ?.idCompanhia,
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
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
                                                            List<EstoqueRow>
                                                                cadastroGeralEstoqueRowList =
                                                                snapshot.data!;

                                                            return Container(
                                                              width: 1000,
                                                              height: 180,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15,
                                                                            0,
                                                                            15,
                                                                            0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            'Produto',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  fontSize: 12,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Expanded(
                                                                              child: FutureBuilder<List<ProdutosRow>>(
                                                                                future: ProdutosTable().queryRows(
                                                                                  queryFn: (q) => q.eqOrNull(
                                                                                    'id_companhia',
                                                                                    cTNNovoProdutoUsuariosRow?.idCompanhia,
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
                                                                                  List<ProdutosRow> containerProdutosRowList = snapshot.data!;

                                                                                  return Container(
                                                                                    decoration: BoxDecoration(),
                                                                                    child: FutureBuilder<List<VwEstoqueAtualRow>>(
                                                                                      future: VwEstoqueAtualTable().queryRows(
                                                                                        queryFn: (q) => q
                                                                                            .eqOrNull(
                                                                                              'id_companhia',
                                                                                              cTNNovoProdutoUsuariosRow?.idCompanhia,
                                                                                            )
                                                                                            .gtOrNull(
                                                                                              'quantidade_atual',
                                                                                              0,
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
                                                                                        List<VwEstoqueAtualRow> produtosVwEstoqueAtualRowList = snapshot.data!;

                                                                                        return FlutterFlowDropDown<String>(
                                                                                          controller: _model.produtosValueController ??= FormFieldController<String>(null),
                                                                                          options: produtosVwEstoqueAtualRowList.map((e) => e.nomeProduto).withoutNulls.toList().sortedList(keyOf: (e) => e, desc: false).unique((e) => e),
                                                                                          onChanged: (val) async {
                                                                                            safeSetState(() => _model.produtosValue = val);
                                                                                            FFAppState().PuxarProduto = _model.produtosValue!;
                                                                                            safeSetState(() {});
                                                                                            _model.saidaTipo23 = await ProdutosTable().queryRows(
                                                                                              queryFn: (q) => q
                                                                                                  .eqOrNull(
                                                                                                    'id_companhia',
                                                                                                    cTNNovoProdutoUsuariosRow?.idCompanhia,
                                                                                                  )
                                                                                                  .eqOrNull(
                                                                                                    'produtos',
                                                                                                    FFAppState().PuxarProduto,
                                                                                                  ),
                                                                                            );
                                                                                            _model.tipoEmbalagem = _model.saidaTipo23?.firstOrNull?.tipoEmbalagem;
                                                                                            safeSetState(() {});

                                                                                            safeSetState(() {});
                                                                                          },
                                                                                          width: 200,
                                                                                          height: 40,
                                                                                          searchHintTextStyle: GoogleFonts.roboto(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 16,
                                                                                          ),
                                                                                          searchTextStyle: GoogleFonts.roboto(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 16,
                                                                                          ),
                                                                                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                          hintText: valueOrDefault<String>(
                                                                                            FFAppState().PuxarProduto,
                                                                                            'Produto',
                                                                                          ),
                                                                                          searchHintText: 'Buscar',
                                                                                          icon: Icon(
                                                                                            Icons.keyboard_arrow_down_rounded,
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            size: 24,
                                                                                          ),
                                                                                          fillColor: FlutterFlowTheme.of(context).primaryText,
                                                                                          elevation: 2,
                                                                                          borderColor: FlutterFlowTheme.of(context).tertiary,
                                                                                          borderWidth: 0,
                                                                                          borderRadius: 8,
                                                                                          margin: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                                                                          hidesUnderline: true,
                                                                                          isOverButton: false,
                                                                                          isSearchable: true,
                                                                                          isMultiSelect: false,
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                            FlutterFlowIconButton(
                                                                              borderRadius: 8,
                                                                              buttonSize: 40,
                                                                              fillColor: FlutterFlowTheme.of(context).success,
                                                                              icon: Icon(
                                                                                Icons.add_circle,
                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                size: 20,
                                                                              ),
                                                                              onPressed: () async {
                                                                                await showModalBottomSheet(
                                                                                  isScrollControlled: true,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  enableDrag: false,
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return Padding(
                                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                                      child: BNovoProdutoWidget(),
                                                                                    );
                                                                                  },
                                                                                ).then((value) => safeSetState(() {}));

                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ].divide(SizedBox(width: 8)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children:
                                                                          [
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                                child: Text(
                                                                                  'Sistema de Medidas',
                                                                                  textAlign: TextAlign.start,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        fontSize: 12,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: double.infinity,
                                                                                child: TextFormField(
                                                                                  controller: _model.tipoEmbalagemTextController,
                                                                                  focusNode: _model.tipoEmbalagemFocusNode,
                                                                                  autofocus: false,
                                                                                  readOnly: true,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                        ),
                                                                                    hintText: valueOrDefault<String>(
                                                                                      _model.tipoEmbalagem,
                                                                                      'Sistema de Medidas',
                                                                                    ),
                                                                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                        ),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x7FF9CF58),
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).warning,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                    errorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                    filled: true,
                                                                                    fillColor: Color(0x00FFFFFF),
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                  keyboardType: TextInputType.number,
                                                                                  cursorColor: FlutterFlowTheme.of(context).warning,
                                                                                  validator: _model.tipoEmbalagemTextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                                child: Text(
                                                                                  'Quantidade',
                                                                                  textAlign: TextAlign.start,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        fontSize: 12,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: double.infinity,
                                                                                child: TextFormField(
                                                                                  controller: _model.quantidadeTextController,
                                                                                  focusNode: _model.quantidadeFocusNode,
                                                                                  autofocus: false,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                        ),
                                                                                    hintText: 'Quantidade',
                                                                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                        ),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x7FF9CF58),
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).warning,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                    errorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                    filled: true,
                                                                                    fillColor: Color(0x00FFFFFF),
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                  keyboardType: TextInputType.number,
                                                                                  cursorColor: FlutterFlowTheme.of(context).warning,
                                                                                  validator: _model.quantidadeTextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 8)),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        FFButtonWidget(
                                                                          onPressed:
                                                                              () async {
                                                                            _model.trazerId =
                                                                                await ProdutosTable().queryRows(
                                                                              queryFn: (q) => q
                                                                                  .eqOrNull(
                                                                                    'id_companhia',
                                                                                    cTNNovoProdutoUsuariosRow?.idCompanhia,
                                                                                  )
                                                                                  .eqOrNull(
                                                                                    'produtos',
                                                                                    FFAppState().PuxarProduto,
                                                                                  ),
                                                                            );
                                                                            await EstoqueTable().insert({
                                                                              'id_produto': _model.trazerId?.firstOrNull?.id,
                                                                              'tipo_embalagem': _model.tipoEmbalagem,
                                                                              'quantidade': int.tryParse(_model.quantidadeTextController.text),
                                                                              'id_companhia': cTNNovoProdutoUsuariosRow?.idCompanhia,
                                                                              'tipo_movimentacao': 'saida',
                                                                            });
                                                                            await EstoqueEvolucaoTable().insert({
                                                                              'id_produto': _model.trazerId?.firstOrNull?.id,
                                                                              'tipo_embalagem': _model.tipoEmbalagem,
                                                                              'quantidade': int.tryParse(_model.quantidadeTextController.text),
                                                                              'id_companhia': cTNNovoProdutoUsuariosRow?.idCompanhia,
                                                                              'id_agendamento': widget!.idagendamento,
                                                                              'tipo_movimentacao': 'saida',
                                                                            });
                                                                            safeSetState(() {
                                                                              _model.produtosValueController?.reset();
                                                                              _model.produtosValue = null;
                                                                            });
                                                                            safeSetState(() {
                                                                              _model.tipoEmbalagemTextController?.clear();
                                                                              _model.quantidadeTextController?.clear();
                                                                            });
                                                                            FFAppState().telaEvolucao =
                                                                                'Atender';
                                                                            safeSetState(() {});

                                                                            safeSetState(() {});
                                                                          },
                                                                          text:
                                                                              'Salvar',
                                                                          options:
                                                                              FFButtonOptions(
                                                                            width:
                                                                                150,
                                                                            height:
                                                                                40,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16,
                                                                                0,
                                                                                16,
                                                                                0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            color:
                                                                                Color(0xA8F9CF58),
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.interTight(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                10,
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          10)),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                        ],
                                      ),
                                    ]
                                        .divide(SizedBox(height: 10))
                                        .around(SizedBox(height: 10)),
                                  ),
                                );
                              },
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
