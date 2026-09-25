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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'a_ficha_evolucao_model.dart';
export 'a_ficha_evolucao_model.dart';

class AFichaEvolucaoWidget extends StatefulWidget {
  const AFichaEvolucaoWidget({
    super.key,
    required this.dataagendamento,
    required this.horarioagendamento,
    required this.idclienteagendamento,
    required this.idagendamento,
    required this.idPlanmoAgendamento,
  });

  final DateTime? dataagendamento;
  final DateTime? horarioagendamento;
  final int? idclienteagendamento;
  final int? idagendamento;
  final int? idPlanmoAgendamento;

  @override
  State<AFichaEvolucaoWidget> createState() => _AFichaEvolucaoWidgetState();
}

class _AFichaEvolucaoWidgetState extends State<AFichaEvolucaoWidget> {
  late AFichaEvolucaoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AFichaEvolucaoModel());

    _model.observcaoTextController ??= TextEditingController();
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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
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
                List<UsuariosRow> cTNGeralUsuariosRowList = snapshot.data!;

                final cTNGeralUsuariosRow = cTNGeralUsuariosRowList.isNotEmpty
                    ? cTNGeralUsuariosRowList.first
                    : null;

                return Material(
                  color: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: 1000,
                    height: 844.43,
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
                          cTNGeralUsuariosRow?.idCompanhia,
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
                                  cTNGeralUsuariosRow?.idCompanhia,
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
                                List<VwEstoqueEvolucaoRow>
                                    containerVwEstoqueEvolucaoRowList =
                                    snapshot.data!;

                                final containerVwEstoqueEvolucaoRow =
                                    containerVwEstoqueEvolucaoRowList.isNotEmpty
                                        ? containerVwEstoqueEvolucaoRowList
                                            .first
                                        : null;

                                return Container(
                                  decoration: BoxDecoration(),
                                  child: FutureBuilder<List<ProdutosRow>>(
                                    future: ProdutosTable().querySingleRow(
                                      queryFn: (q) => q.eqOrNull(
                                        'id_companhia',
                                        cTNGeralUsuariosRow?.idCompanhia,
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
                                                  FlutterFlowTheme.of(context)
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
                                          linhaCabecalhoProdutosRowList
                                                  .isNotEmpty
                                              ? linhaCabecalhoProdutosRowList
                                                  .first
                                              : null;

                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 12, 0, 8),
                                            child: Text(
                                              'EvoluÃ§Ã£o do Cliente',
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        fontSize: 16,
                                                        letterSpacing: 0.0,
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
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 5, 0),
                                            child:
                                                FutureBuilder<List<EstoqueRow>>(
                                              future:
                                                  EstoqueTable().querySingleRow(
                                                queryFn: (q) => q.eqOrNull(
                                                  'id_companhia',
                                                  cTNGeralUsuariosRow
                                                      ?.idCompanhia,
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
                                                List<EstoqueRow>
                                                    iconEstoqueRowList =
                                                    snapshot.data!;

                                                final iconEstoqueRow =
                                                    iconEstoqueRowList
                                                            .isNotEmpty
                                                        ? iconEstoqueRowList
                                                            .first
                                                        : null;

                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
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
                                                              widget!
                                                                  .idagendamento,
                                                            )
                                                            .eqOrNull(
                                                              'id_produto',
                                                              containerVwEstoqueEvolucaoRow
                                                                  ?.idProduto,
                                                            )
                                                            .eqOrNull(
                                                              'quantidade',
                                                              containerVwEstoqueEvolucaoRow
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
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
                              height: 785,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 15, 0),
                                child: FutureBuilder<List<PlanosRow>>(
                                  future: PlanosTable().querySingleRow(
                                    queryFn: (q) => q
                                        .eqOrNull(
                                          'id_companhia',
                                          cTNGeralUsuariosRow?.idCompanhia,
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

                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 10),
                                          child:
                                              FutureBuilder<List<ClientesRow>>(
                                            future:
                                                ClientesTable().querySingleRow(
                                              queryFn: (q) => q
                                                  .eqOrNull(
                                                    'id_companhia',
                                                    cTNGeralUsuariosRow
                                                        ?.idCompanhia,
                                                  )
                                                  .eqOrNull(
                                                    'id',
                                                    widget!
                                                        .idclienteagendamento,
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
                                              List<ClientesRow>
                                                  cTNInformacoesClientesRowList =
                                                  snapshot.data!;

                                              final cTNInformacoesClientesRow =
                                                  cTNInformacoesClientesRowList
                                                          .isNotEmpty
                                                      ? cTNInformacoesClientesRowList
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
                                                          cTNGeralUsuariosRow
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
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                  cTNInformacoesClientesRow
                                                                      ?.nome,
                                                                  'Nome',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                    cTNInformacoesClientesRow
                                                                        ?.dataNascimento,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ),
                                                                  'Data de Nascimento',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                    ' |  CPF: ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                  cTNInformacoesClientesRow
                                                                      ?.cpf,
                                                                  'CPF',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                  "d/M/y",
                                                                  widget!
                                                                      .dataagendamento,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                  columnPlanosRow
                                                                      ?.nomePlano,
                                                                  'Plano',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                decoration: BoxDecoration(),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
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
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      fontSize:
                                                                          18,
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
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
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
                                                                    final selectedMedia =
                                                                        await selectMediaWithSourceBottomSheet(
                                                                      context:
                                                                          context,
                                                                      storageFolderPath:
                                                                          'antes',
                                                                      allowPhoto:
                                                                          true,
                                                                    );
                                                                    if (selectedMedia !=
                                                                            null &&
                                                                        selectedMedia.every((m) => validateFileFormat(
                                                                            m.storagePath,
                                                                            context))) {
                                                                      safeSetState(() =>
                                                                          _model.isDataUploading_antes =
                                                                              true);
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

                                                                        downloadUrls =
                                                                            await uploadSupabaseStorageFiles(
                                                                          bucketName:
                                                                              'vsbgaleria',
                                                                          selectedFiles:
                                                                              selectedMedia,
                                                                        );
                                                                      } finally {
                                                                        _model.isDataUploading_antes =
                                                                            false;
                                                                      }
                                                                      if (selectedUploadedFiles.length ==
                                                                              selectedMedia
                                                                                  .length &&
                                                                          downloadUrls.length ==
                                                                              selectedMedia.length) {
                                                                        safeSetState(
                                                                            () {
                                                                          _model.uploadedLocalFile_antes =
                                                                              selectedUploadedFiles.first;
                                                                          _model.uploadedFileUrl_antes =
                                                                              downloadUrls.first;
                                                                        });
                                                                      } else {
                                                                        safeSetState(
                                                                            () {});
                                                                        return;
                                                                      }
                                                                    }

                                                                    _model.antesEvolucao =
                                                                        _model
                                                                            .uploadedFileUrl_antes;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    child: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        _model
                                                                            .antesEvolucao,
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vision-smart-beauty-l7vxwr/assets/hswlxpa4jllv/upload-icon-32.png',
                                                                      ),
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .cover,
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
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      fontSize:
                                                                          18,
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
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
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
                                                                    final selectedMedia =
                                                                        await selectMediaWithSourceBottomSheet(
                                                                      context:
                                                                          context,
                                                                      storageFolderPath:
                                                                          'depois',
                                                                      allowPhoto:
                                                                          true,
                                                                    );
                                                                    if (selectedMedia !=
                                                                            null &&
                                                                        selectedMedia.every((m) => validateFileFormat(
                                                                            m.storagePath,
                                                                            context))) {
                                                                      safeSetState(() =>
                                                                          _model.isDataUploading_depois =
                                                                              true);
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

                                                                        downloadUrls =
                                                                            await uploadSupabaseStorageFiles(
                                                                          bucketName:
                                                                              'vsbgaleria',
                                                                          selectedFiles:
                                                                              selectedMedia,
                                                                        );
                                                                      } finally {
                                                                        _model.isDataUploading_depois =
                                                                            false;
                                                                      }
                                                                      if (selectedUploadedFiles.length ==
                                                                              selectedMedia
                                                                                  .length &&
                                                                          downloadUrls.length ==
                                                                              selectedMedia.length) {
                                                                        safeSetState(
                                                                            () {
                                                                          _model.uploadedLocalFile_depois =
                                                                              selectedUploadedFiles.first;
                                                                          _model.uploadedFileUrl_depois =
                                                                              downloadUrls.first;
                                                                        });
                                                                      } else {
                                                                        safeSetState(
                                                                            () {});
                                                                        return;
                                                                      }
                                                                    }

                                                                    _model.depoisEvolucao =
                                                                        _model
                                                                            .uploadedFileUrl_depois;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    child: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        _model
                                                                            .depoisEvolucao,
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vision-smart-beauty-l7vxwr/assets/hswlxpa4jllv/upload-icon-32.png',
                                                                      ),
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 1100,
                                                      height: 180.4,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                        ),
                                                      ),
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          controller: _model
                                                              .observcaoTextController,
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
                                                            hintText:
                                                                'ObservaÃ§Ã£o',
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
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
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0x00000000),
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
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 10,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
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
                                                                  padding: EdgeInsetsDirectional
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        fontSize:
                                                                            16,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                      height: 270.3,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        'Produtos',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 200,
                                                                    height: 50,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        'Sistema de Medidas',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 200,
                                                                    height: 50,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        'Quantidade',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 200,
                                                                    height: 50,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        'Excluir',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 220,
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
                                                                              columnPlanosRow?.idCompanhia,
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
                                                                              width: 50,
                                                                              height: 50,
                                                                              child: SpinKitFadingFour(
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                size: 50,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        List<VwEstoqueEvolucaoRow>
                                                                            listViewVwEstoqueEvolucaoRowList =
                                                                            snapshot.data!;

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
                                                                          separatorBuilder: (_, __) =>
                                                                              SizedBox(height: 10),
                                                                          itemBuilder:
                                                                              (context, listViewIndex) {
                                                                            final listViewVwEstoqueEvolucaoRow =
                                                                                listViewVwEstoqueEvolucaoRowList[listViewIndex];
                                                                            return Container(
                                                                              height: 50,
                                                                              decoration: BoxDecoration(),
                                                                              child: FutureBuilder<List<ProdutosRow>>(
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
                                                    Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          if (_model
                                                                  .observcaoTextController
                                                                  .text !=
                                                              '') {
                                                            await EvolucaoClienteTable()
                                                                .insert({
                                                              'id_agendamento':
                                                                  widget!
                                                                      .idagendamento,
                                                              'observacao': _model
                                                                  .observcaoTextController
                                                                  .text,
                                                              'antes': _model
                                                                  .antesEvolucao,
                                                              'depois': _model
                                                                  .depoisEvolucao,
                                                              'id_companhia':
                                                                  cTNGeralUsuariosRow
                                                                      ?.idCompanhia,
                                                            });
                                                            await AgendamentoTable()
                                                                .update(
                                                              data: {
                                                                'status_procedimento':
                                                                    'ConcluÃ­do',
                                                              },
                                                              matchingRows:
                                                                  (rows) => rows
                                                                      .eqOrNull(
                                                                        'id_companhia',
                                                                        cTNGeralUsuariosRow
                                                                            ?.idCompanhia,
                                                                      )
                                                                      .eqOrNull(
                                                                        'id_cliente',
                                                                        columnPlanosRow
                                                                            ?.idCliente,
                                                                      )
                                                                      .eqOrNull(
                                                                        'id',
                                                                        widget!
                                                                            .idagendamento,
                                                                      ),
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'EvoluÃ§Ã£o do cliente inserida com sucesso!',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                              ),
                                                            );
                                                          } else {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Alerta!'),
                                                                  content: Text(
                                                                      'VocÃª nÃ£o preencheu todos os campos'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          'Ok'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                        text: 'Salvar',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 150,
                                                          height: 47.41,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          color:
                                                              Color(0xA8F9CF58),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .interTight(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 10,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 10)),
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
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                            color: Color(
                                                                0x33000000),
                                                            offset: Offset(
                                                              0,
                                                              2,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                                MainAxisSize
                                                                    .max,
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
                                                                  splashColor:
                                                                      Colors
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
                                                            future:
                                                                EstoqueTable()
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
                                                              List<EstoqueRow>
                                                                  cadastroGeralEstoqueRowList =
                                                                  snapshot
                                                                      .data!;

                                                              return Container(
                                                                width: 1000,
                                                                height: 180,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
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
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
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
                                                                                      cTNGeralUsuariosRow?.idCompanhia,
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
                                                                                              _model.saidaTipo2 = await ProdutosTable().queryRows(
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
                                                                                              _model.tipoEmbalagem = _model.saidaTipo2?.firstOrNull?.tipoEmbalagem;
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
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                        ].divide(SizedBox(width: 8)),
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              _model.trazerId = await ProdutosTable().queryRows(
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
                                                                              FFAppState().telaEvolucao = 'Atender';
                                                                              safeSetState(() {});

                                                                              safeSetState(() {});
                                                                            },
                                                                            text:
                                                                                'Salvar',
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: 150,
                                                                              height: 40,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                              color: Color(0xA8F9CF58),
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
                                                                              elevation: 10,
                                                                              borderRadius: BorderRadius.circular(15),
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
        ),
      ],
    );
  }
}
