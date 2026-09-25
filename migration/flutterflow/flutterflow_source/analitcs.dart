import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'analytics_model.dart';
export 'analytics_model.dart';

class AnalyticsWidget extends StatefulWidget {
  const AnalyticsWidget({super.key});

  static String routeName = 'Analytics';
  static String routePath = '/Analytics';

  @override
  State<AnalyticsWidget> createState() => _AnalyticsWidgetState();
}

class _AnalyticsWidgetState extends State<AnalyticsWidget> {
  late AnalyticsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnalyticsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.procedimentoTop = FFAppState().UpdateAnalytics;
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
    context.watch<FFAppState>();
    final chartPieChartColorsList1 = [
      FlutterFlowTheme.of(context).primary,
      Color(0xFFFF00CB),
      Color(0xFFFBBA03)
    ];
    final chartPieChartColorsList2 = [
      FlutterFlowTheme.of(context).primary,
      Color(0xFFFF00CB),
      Color(0xFFFBBA03)
    ];
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
        List<UsuariosRow> analyticsUsuariosRowList = snapshot.data!;

        final analyticsUsuariosRow = analyticsUsuariosRowList.isNotEmpty
            ? analyticsUsuariosRowList.first
            : null;

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
              child: Visibility(
                visible: responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                ),
                child: FutureBuilder<List<CompanhiaRow>>(
                  future: CompanhiaTable().querySingleRow(
                    queryFn: (q) => q.eqOrNull(
                      'id',
                      analyticsUsuariosRow?.idCompanhia,
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
                    List<CompanhiaRow> cTNAnalyticsCompanhiaRowList =
                        snapshot.data!;

                    final cTNAnalyticsCompanhiaRow =
                        cTNAnalyticsCompanhiaRowList.isNotEmpty
                            ? cTNAnalyticsCompanhiaRowList.first
                            : null;

                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          25, 10, 10, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Visão Analítica',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiary,
                                                  fontSize: 22,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 3, 0, 0),
                                            child: FutureBuilder<
                                                List<
                                                    VwAnalyticsFinanceiroMensalCompletoRow>>(
                                              future:
                                                  VwAnalyticsFinanceiroMensalCompletoTable()
                                                      .queryRows(
                                                queryFn: (q) => q.eqOrNull(
                                                  'id_companhia',
                                                  analyticsUsuariosRow
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
                                                List<VwAnalyticsFinanceiroMensalCompletoRow>
                                                    dropDownGeralAnoVwAnalyticsFinanceiroMensalCompletoRowList =
                                                    snapshot.data!;

                                                return FlutterFlowDropDown<int>(
                                                  controller: _model
                                                          .dropDownGeralAnoValueController ??=
                                                      FormFieldController<int>(
                                                    _model.dropDownGeralAnoValue ??=
                                                        FFAppState()
                                                            .AnoAnalytics,
                                                  ),
                                                  options: List<int>.from(
                                                      dropDownGeralAnoVwAnalyticsFinanceiroMensalCompletoRowList
                                                          .map((e) => e.ano)
                                                          .withoutNulls
                                                          .toList()
                                                          .unique((e) =>
                                                              e.toString())
                                                          .sortedList(
                                                              keyOf: (e) => e,
                                                              desc: false)),
                                                  optionLabels:
                                                      dropDownGeralAnoVwAnalyticsFinanceiroMensalCompletoRowList
                                                          .map((e) =>
                                                              e.ano.toString())
                                                          .toList()
                                                          .sortedList(
                                                              keyOf: (e) => e,
                                                              desc: false)
                                                          .unique((e) => e),
                                                  onChanged: (val) async {
                                                    safeSetState(() => _model
                                                            .dropDownGeralAnoValue =
                                                        val);
                                                    FFAppState().AnoAnalytics =
                                                        _model
                                                            .dropDownGeralAnoValue!;
                                                    safeSetState(() {});
                                                  },
                                                  width: 200,
                                                  height: 30,
                                                  searchHintTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
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
                                                                .secondaryBackground,
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
                                                  searchTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                  hintText: 'Selecione um ano',
                                                  searchHintText:
                                                      'Selecione o Ano',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    size: 24,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  elevation: 2,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tertiary,
                                                  borderWidth: 0,
                                                  borderRadius: 8,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(12, 0, 12, 0),
                                                  hidesUnderline: true,
                                                  isOverButton: false,
                                                  isSearchable: true,
                                                  isMultiSelect: false,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                    ),
                                    Container(
                                      width: 1400,
                                      height: 770,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              height: 755,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  FutureBuilder<
                                                      List<
                                                          VwAnalyticsFinanceiroAnualRow>>(
                                                    future:
                                                        VwAnalyticsFinanceiroAnualTable()
                                                            .querySingleRow(
                                                      queryFn: (q) => q
                                                          .eqOrNull(
                                                            'id_companhia',
                                                            analyticsUsuariosRow
                                                                ?.idCompanhia,
                                                          )
                                                          .eqOrNull(
                                                            'ano',
                                                            FFAppState()
                                                                .AnoAnalytics
                                                                .toDouble(),
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
                                                      List<VwAnalyticsFinanceiroAnualRow>
                                                          cTNFinanceiroVwAnalyticsFinanceiroAnualRowList =
                                                          snapshot.data!;

                                                      final cTNFinanceiroVwAnalyticsFinanceiroAnualRow =
                                                          cTNFinanceiroVwAnalyticsFinanceiroAnualRowList
                                                                  .isNotEmpty
                                                              ? cTNFinanceiroVwAnalyticsFinanceiroAnualRowList
                                                                  .first
                                                              : null;

                                                      return Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 15,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Container(
                                                          width: 450,
                                                          height: 240,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF010101),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1, 0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          5,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    'Painel de Desempenho Financeiro',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                          fontSize:
                                                                              18,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Divider(
                                                                thickness: 2,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 55,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          formatNumber(
                                                                            cTNFinanceiroVwAnalyticsFinanceiroAnualRow!.receita!,
                                                                            formatType:
                                                                                FormatType.custom,
                                                                            currency:
                                                                                'R\$ ',
                                                                            format:
                                                                                '#,###.00',
                                                                            locale:
                                                                                'pt-BR',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).success,
                                                                                fontSize: 25,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          'Faturamento',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                fontSize: 15,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 1,
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 55,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        formatNumber(
                                                                          cTNFinanceiroVwAnalyticsFinanceiroAnualRow!
                                                                              .lucro!,
                                                                          formatType:
                                                                              FormatType.custom,
                                                                          currency:
                                                                              'R\$ ',
                                                                          format:
                                                                              '#,###.00',
                                                                          locale:
                                                                              'pt-BR',
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                              fontSize: 25,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        'Lucro',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              fontSize: 15,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 55,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Text(
                                                                          formatNumber(
                                                                            cTNFinanceiroVwAnalyticsFinanceiroAnualRow!.despesa!,
                                                                            formatType:
                                                                                FormatType.custom,
                                                                            currency:
                                                                                'R\$ ',
                                                                            format:
                                                                                '#,###.00',
                                                                            locale:
                                                                                'pt-BR',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                fontSize: 25,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          'Despesas',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                fontSize: 15,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Material(
                                                    color: Colors.transparent,
                                                    elevation: 15,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Container(
                                                      width: 453.6,
                                                      height: 240,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF010101),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1, 0),
                                                            child: Container(
                                                              height: 34,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            5,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  'Painel de Indicadores de Clientes',
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                        fontSize:
                                                                            18,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Divider(
                                                            thickness: 2,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              FutureBuilder<
                                                                  List<
                                                                      VwAnalyticsTotalClientesRow>>(
                                                                future: VwAnalyticsTotalClientesTable()
                                                                    .querySingleRow(
                                                                  queryFn: (q) => q
                                                                      .eqOrNull(
                                                                        'id_companhia',
                                                                        analyticsUsuariosRow
                                                                            ?.idCompanhia,
                                                                      )
                                                                      .eqOrNull(
                                                                        'ano',
                                                                        FFAppState()
                                                                            .AnoAnalytics,
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
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            SpinKitFadingFour(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                          size:
                                                                              50,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<VwAnalyticsTotalClientesRow>
                                                                      cTNTotalClientesVwAnalyticsTotalClientesRowList =
                                                                      snapshot
                                                                          .data!;

                                                                  final cTNTotalClientesVwAnalyticsTotalClientesRow = cTNTotalClientesVwAnalyticsTotalClientesRowList
                                                                          .isNotEmpty
                                                                      ? cTNTotalClientesVwAnalyticsTotalClientesRowList
                                                                          .first
                                                                      : null;

                                                                  return Container(
                                                                    width:
                                                                        167.1,
                                                                    height: 200,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          'Total de Clientes',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                fontSize: 15,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            cTNTotalClientesVwAnalyticsTotalClientesRow?.totalClientes.toString(),
                                                                            '00',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                fontSize: 40,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 60)),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              FutureBuilder<
                                                                  List<
                                                                      VwAnalyticsClientesGeneroRow>>(
                                                                future:
                                                                    VwAnalyticsClientesGeneroTable()
                                                                        .queryRows(
                                                                  queryFn: (q) => q
                                                                      .eqOrNull(
                                                                        'id_companhia',
                                                                        analyticsUsuariosRow
                                                                            ?.idCompanhia,
                                                                      )
                                                                      .eqOrNull(
                                                                        'ano',
                                                                        FFAppState()
                                                                            .AnoAnalytics,
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
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            SpinKitFadingFour(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                          size:
                                                                              50,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<VwAnalyticsClientesGeneroRow>
                                                                      cTNGeneroVwAnalyticsClientesGeneroRowList =
                                                                      snapshot
                                                                          .data!;

                                                                  return Container(
                                                                    width:
                                                                        277.4,
                                                                    height: 200,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Column(
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
                                                                        Text(
                                                                          'Distribuição por Gênero',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                fontSize: 15,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: 91.4,
                                                                              height: 177.9,
                                                                              child: Stack(
                                                                                children: [
                                                                                  FlutterFlowPieChart(
                                                                                    data: FFPieChartData(
                                                                                      values: cTNGeneroVwAnalyticsClientesGeneroRowList.map((e) => e.totalClientes).withoutNulls.toList(),
                                                                                      colors: chartPieChartColorsList1,
                                                                                      radius: [0],
                                                                                      borderColor: [
                                                                                        Color(0x0014181B)
                                                                                      ],
                                                                                    ),
                                                                                    donutHoleRadius: 0,
                                                                                    donutHoleColor: Colors.transparent,
                                                                                    sectionLabelType: PieChartSectionLabelType.value,
                                                                                    sectionLabelStyle: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                          font: GoogleFonts.interTight(
                                                                                            fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(-1, 0),
                                                                                    child: FlutterFlowChartLegendWidget(
                                                                                      entries: cTNGeneroVwAnalyticsClientesGeneroRowList
                                                                                          .map((e) => e.genero)
                                                                                          .withoutNulls
                                                                                          .toList()
                                                                                          .asMap()
                                                                                          .entries
                                                                                          .map(
                                                                                            (label) => LegendEntry(
                                                                                              chartPieChartColorsList1[label.key % chartPieChartColorsList1.length],
                                                                                              label.value,
                                                                                            ),
                                                                                          )
                                                                                          .toList(),
                                                                                      width: 100,
                                                                                      height: 50,
                                                                                      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                                                      textPadding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                                      backgroundColor: Colors.transparent,
                                                                                      borderColor: Colors.transparent,
                                                                                      indicatorSize: 10,
                                                                                      indicatorBorderRadius: BorderRadius.circular(24),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: 186.5,
                                                                              height: 179.6,
                                                                              child: FlutterFlowPieChart(
                                                                                data: FFPieChartData(
                                                                                  values: cTNGeneroVwAnalyticsClientesGeneroRowList.map((e) => e.totalClientes.toString()).toList(),
                                                                                  colors: chartPieChartColorsList2,
                                                                                  radius: [80],
                                                                                  borderColor: [
                                                                                    Color(0x0014181B)
                                                                                  ],
                                                                                ),
                                                                                donutHoleRadius: 0,
                                                                                donutHoleColor: Colors.transparent,
                                                                                sectionLabelType: PieChartSectionLabelType.value,
                                                                                sectionLabelStyle: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                      font: GoogleFonts.interTight(
                                                                                        fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  FutureBuilder<
                                                      List<
                                                          VwAnalyticsAtendimentosResumoRow>>(
                                                    future:
                                                        VwAnalyticsAtendimentosResumoTable()
                                                            .queryRows(
                                                      queryFn: (q) => q
                                                          .eqOrNull(
                                                            'id_companhia',
                                                            analyticsUsuariosRow
                                                                ?.idCompanhia,
                                                          )
                                                          .eqOrNull(
                                                            'ano',
                                                            FFAppState()
                                                                .AnoAnalytics,
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
                                                      List<VwAnalyticsAtendimentosResumoRow>
                                                          cTNAtendimentoVwAnalyticsAtendimentosResumoRowList =
                                                          snapshot.data!;

                                                      return Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 15,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Container(
                                                          width: 450,
                                                          height: 240,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF010101),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1, 0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          5,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    'Painel de Performance dos Atendimentos',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                          fontSize:
                                                                              18,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Divider(
                                                                thickness: 2,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        168.4,
                                                                    height: 200,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children:
                                                                          [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              20,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            'Volume de Atendimentos',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            cTNAtendimentoVwAnalyticsAtendimentosResumoRowList.firstOrNull?.totalAtendimentos.toString(),
                                                                            '00',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                fontSize: 40,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 60)),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 280,
                                                                    height: 200,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Column(
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
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              20,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            'Status dos\n Atendimentos',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              20,
                                                                              0,
                                                                              20),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                                                                                child: Container(
                                                                                  width: 30,
                                                                                  height: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).success,
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'Concluído: ',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      fontSize: 15,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  cTNAtendimentoVwAnalyticsAtendimentosResumoRowList.firstOrNull?.atendimentosConcluidos.toString(),
                                                                                  '00',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      fontSize: 15,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              20),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                                                                                child: Container(
                                                                                  width: 30,
                                                                                  height: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).warning,
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'Pendente:  ',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      fontSize: 15,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  cTNAtendimentoVwAnalyticsAtendimentosResumoRowList.firstOrNull?.atendimentosAgendados.toString(),
                                                                                  '00',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      fontSize: 15,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                                                                              child: Container(
                                                                                width: 30,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Cancelado: ',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              valueOrDefault<String>(
                                                                                cTNAtendimentoVwAnalyticsAtendimentosResumoRowList.firstOrNull?.atendimentosCancelados.toString(),
                                                                                '00',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ].divide(SizedBox(height: 10)),
                                              ),
                                            ),
                                            Container(
                                              width: 912,
                                              height: 755,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Material(
                                                    color: Colors.transparent,
                                                    elevation: 15,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Container(
                                                      width: 900,
                                                      height: 240,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF010101),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        10,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            5,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Desempenho Financeiro por Mês',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            fontSize:
                                                                                18,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                            thickness: 2,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                          ),
                                                          FutureBuilder<
                                                              List<
                                                                  VwAnalyticsFinanceiroMensalCompletoRow>>(
                                                            future:
                                                                VwAnalyticsFinanceiroMensalCompletoTable()
                                                                    .queryRows(
                                                              queryFn: (q) => q
                                                                  .eqOrNull(
                                                                    'id_companhia',
                                                                    analyticsUsuariosRow
                                                                        ?.idCompanhia,
                                                                  )
                                                                  .eqOrNull(
                                                                    'ano',
                                                                    FFAppState()
                                                                        .AnoAnalytics,
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
                                                              List<VwAnalyticsFinanceiroMensalCompletoRow>
                                                                  cTNGraficoVwAnalyticsFinanceiroMensalCompletoRowList =
                                                                  snapshot
                                                                      .data!;

                                                              return Container(
                                                                width: 900,
                                                                height: 195,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: 870,
                                                                    height:
                                                                        169.6,
                                                                    child:
                                                                        FlutterFlowBarChart(
                                                                      barData: [
                                                                        FFBarChartData(
                                                                          yData: cTNGraficoVwAnalyticsFinanceiroMensalCompletoRowList
                                                                              .map((e) => e.receita)
                                                                              .withoutNulls
                                                                              .toList(),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).success,
                                                                        ),
                                                                        FFBarChartData(
                                                                          yData: cTNGraficoVwAnalyticsFinanceiroMensalCompletoRowList
                                                                              .map((e) => e.despesa)
                                                                              .withoutNulls
                                                                              .toList(),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                        ),
                                                                        FFBarChartData(
                                                                          yData: cTNGraficoVwAnalyticsFinanceiroMensalCompletoRowList
                                                                              .map((e) => e.lucro)
                                                                              .withoutNulls
                                                                              .toList(),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).warning,
                                                                        )
                                                                      ],
                                                                      xLabels: cTNGraficoVwAnalyticsFinanceiroMensalCompletoRowList
                                                                          .map((e) =>
                                                                              e.nomeMes)
                                                                          .withoutNulls
                                                                          .toList(),
                                                                      barWidth:
                                                                          10,
                                                                      barBorderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      barSpace:
                                                                          5,
                                                                      groupSpace:
                                                                          30,
                                                                      alignment:
                                                                          BarChartAlignment
                                                                              .spaceBetween,
                                                                      chartStylingInfo:
                                                                          ChartStylingInfo(
                                                                        enableTooltip:
                                                                            true,
                                                                        tooltipBackgroundColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        backgroundColor:
                                                                            Colors.black,
                                                                        showBorder:
                                                                            false,
                                                                      ),
                                                                      axisBounds:
                                                                          AxisBounds(),
                                                                      xAxisLabelInfo:
                                                                          AxisLabelInfo(
                                                                        showLabels:
                                                                            true,
                                                                        labelTextStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                        labelInterval:
                                                                            10,
                                                                        reservedSize:
                                                                            28,
                                                                      ),
                                                                      yAxisLabelInfo:
                                                                          AxisLabelInfo(
                                                                        reservedSize:
                                                                            0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        FutureBuilder<
                                                            List<
                                                                VwAnalyticsProcedimentosTop10Row>>(
                                                          future:
                                                              VwAnalyticsProcedimentosTop10Table()
                                                                  .queryRows(
                                                            queryFn: (q) => q
                                                                .eqOrNull(
                                                                  'id_companhia',
                                                                  analyticsUsuariosRow
                                                                      ?.idCompanhia,
                                                                )
                                                                .eqOrNull(
                                                                  'ano',
                                                                  FFAppState()
                                                                      .AnoAnalytics,
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
                                                            List<VwAnalyticsProcedimentosTop10Row>
                                                                cTNProcedimentosRealizadosVwAnalyticsProcedimentosTop10RowList =
                                                                snapshot.data!;

                                                            return Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 15,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child: Container(
                                                                width: 900,
                                                                height: 240,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFF010101),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              10,
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1, 0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                                                              child: Text(
                                                                                'Desempenho dos Procedimentos',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                                                      fontSize: 18,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Stack(
                                                                            children: [
                                                                              if (_model.procedimentoTop == 'TOP_10')
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(-1, 0),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                                                                    child: Text(
                                                                                      'Top 10 Procedimento Realizados',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 18,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if (_model.procedimentoTop == 'Lista_TOP')
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(-1, 0),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                                                                    child: Text(
                                                                                      'Lista Completa de Procedimento Realizados',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 18,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                          Stack(
                                                                            children: [
                                                                              if (_model.procedimentoTop == 'TOP_10')
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                                                                                  child: FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      _model.procedimentoTop = 'Lista_TOP';
                                                                                      safeSetState(() {});
                                                                                    },
                                                                                    text: 'LIsta Completa',
                                                                                    options: FFButtonOptions(
                                                                                      width: 120,
                                                                                      height: 30,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            font: GoogleFonts.interTight(
                                                                                              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 14,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 10,
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if (_model.procedimentoTop == 'Lista_TOP')
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                                                                                  child: FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      _model.procedimentoTop = 'TOP_10';
                                                                                      safeSetState(() {});
                                                                                    },
                                                                                    text: 'TOP 10',
                                                                                    options: FFButtonOptions(
                                                                                      width: 120,
                                                                                      height: 30,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            font: GoogleFonts.interTight(
                                                                                              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 14,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 10,
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Divider(
                                                                      thickness:
                                                                          2,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .tertiary,
                                                                    ),
                                                                    SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Stack(
                                                                            children: [
                                                                              if (_model.procedimentoTop == 'TOP_10')
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                                                                  child: Container(
                                                                                    width: 870,
                                                                                    height: 190,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Container(
                                                                                      width: 870,
                                                                                      height: 189,
                                                                                      child: FlutterFlowBarChart(
                                                                                        barData: [
                                                                                          FFBarChartData(
                                                                                            yData: cTNProcedimentosRealizadosVwAnalyticsProcedimentosTop10RowList.map((e) => e.totalRealizados).withoutNulls.toList(),
                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                          )
                                                                                        ],
                                                                                        xLabels: cTNProcedimentosRealizadosVwAnalyticsProcedimentosTop10RowList.map((e) => e.nomeProcedimento).withoutNulls.toList(),
                                                                                        barWidth: 10,
                                                                                        barBorderRadius: BorderRadius.circular(8),
                                                                                        groupSpace: 30,
                                                                                        alignment: BarChartAlignment.spaceAround,
                                                                                        chartStylingInfo: ChartStylingInfo(
                                                                                          enableTooltip: true,
                                                                                          tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                          backgroundColor: Colors.black,
                                                                                          showBorder: false,
                                                                                        ),
                                                                                        axisBounds: AxisBounds(),
                                                                                        xAxisLabelInfo: AxisLabelInfo(
                                                                                          showLabels: true,
                                                                                          labelTextStyle: TextStyle(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 10,
                                                                                          ),
                                                                                          labelInterval: 10,
                                                                                          reservedSize: 28,
                                                                                        ),
                                                                                        yAxisLabelInfo: AxisLabelInfo(
                                                                                          reservedSize: 0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if (_model.procedimentoTop == 'Lista_TOP')
                                                                                Container(
                                                                                  width: 900,
                                                                                  height: 186.57,
                                                                                  child: SingleChildScrollView(
                                                                                    primary: false,
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 8),
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 200,
                                                                                                decoration: BoxDecoration(),
                                                                                                child: Text(
                                                                                                  'Nome do Procedimento',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.inter(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).warning,
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
                                                                                                child: Text(
                                                                                                  'Quantidade Realizada',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.inter(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).warning,
                                                                                                        fontSize: 14,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          height: 160,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: FutureBuilder<List<VwAnalyticsProcedimentosTopRow>>(
                                                                                            future: VwAnalyticsProcedimentosTopTable().queryRows(
                                                                                              queryFn: (q) => q
                                                                                                  .eqOrNull(
                                                                                                    'id_companhia',
                                                                                                    analyticsUsuariosRow?.idCompanhia,
                                                                                                  )
                                                                                                  .eqOrNull(
                                                                                                    'ano',
                                                                                                    FFAppState().AnoAnalytics,
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
                                                                                              List<VwAnalyticsProcedimentosTopRow> listViewFiltradoVwAnalyticsProcedimentosTopRowList = snapshot.data!;

                                                                                              return ListView.separated(
                                                                                                padding: EdgeInsets.zero,
                                                                                                shrinkWrap: true,
                                                                                                scrollDirection: Axis.vertical,
                                                                                                itemCount: listViewFiltradoVwAnalyticsProcedimentosTopRowList.length,
                                                                                                separatorBuilder: (_, __) => SizedBox(height: 8),
                                                                                                itemBuilder: (context, listViewFiltradoIndex) {
                                                                                                  final listViewFiltradoVwAnalyticsProcedimentosTopRow = listViewFiltradoVwAnalyticsProcedimentosTopRowList[listViewFiltradoIndex];
                                                                                                  return Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
                                                                                                    child: Material(
                                                                                                      color: Colors.transparent,
                                                                                                      elevation: 10,
                                                                                                      shape: RoundedRectangleBorder(
                                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                                      ),
                                                                                                      child: Container(
                                                                                                        width: 600,
                                                                                                        height: 30,
                                                                                                        decoration: BoxDecoration(
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
                                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                                        child: SingleChildScrollView(
                                                                                                          primary: false,
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                children: [
                                                                                                                  Container(
                                                                                                                    width: 350,
                                                                                                                    height: 30,
                                                                                                                    decoration: BoxDecoration(),
                                                                                                                    alignment: AlignmentDirectional(0, 0),
                                                                                                                    child: Text(
                                                                                                                      valueOrDefault<String>(
                                                                                                                        listViewFiltradoVwAnalyticsProcedimentosTopRow.nomeProcedimento,
                                                                                                                        'Nome',
                                                                                                                      ),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.inter(
                                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                            fontSize: 14,
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Align(
                                                                                                                    alignment: AlignmentDirectional(0, 0),
                                                                                                                    child: Container(
                                                                                                                      width: 350,
                                                                                                                      height: 30,
                                                                                                                      decoration: BoxDecoration(),
                                                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                                                      child: Text(
                                                                                                                        valueOrDefault<String>(
                                                                                                                          listViewFiltradoVwAnalyticsProcedimentosTopRow.totalRealizados.toString(),
                                                                                                                          '00',
                                                                                                                        ),
                                                                                                                        textAlign: TextAlign.center,
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              font: GoogleFonts.inter(
                                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                              ),
                                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                              fontSize: 14,
                                                                                                                              letterSpacing: 0.0,
                                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 10)),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 15,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Container(
                                                            width: 450,
                                                            height: 240,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF010101),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            5,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Análise do Melhor Período do Dia',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            fontSize:
                                                                                18,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  thickness: 2,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          VwAnalyticsPeriodoDiaRow>>(
                                                                    future: VwAnalyticsPeriodoDiaTable()
                                                                        .queryRows(
                                                                      queryFn: (q) => q
                                                                          .eqOrNull(
                                                                            'id_companhia',
                                                                            analyticsUsuariosRow?.idCompanhia,
                                                                          )
                                                                          .eqOrNull(
                                                                            'ano',
                                                                            FFAppState().AnoAnalytics,
                                                                          ),
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
                                                                      List<VwAnalyticsPeriodoDiaRow>
                                                                          cTNGraficoVwAnalyticsPeriodoDiaRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return Container(
                                                                        width:
                                                                            870,
                                                                        height:
                                                                            190,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              870,
                                                                          height:
                                                                              189,
                                                                          child:
                                                                              FlutterFlowBarChart(
                                                                            barData: [
                                                                              FFBarChartData(
                                                                                yData: cTNGraficoVwAnalyticsPeriodoDiaRowList.map((e) => e.totalAtendimentos.toString()).toList(),
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                              )
                                                                            ],
                                                                            xLabels:
                                                                                cTNGraficoVwAnalyticsPeriodoDiaRowList.map((e) => e.periodo).withoutNulls.toList(),
                                                                            barWidth:
                                                                                10,
                                                                            barBorderRadius:
                                                                                BorderRadius.circular(8),
                                                                            groupSpace:
                                                                                30,
                                                                            alignment:
                                                                                BarChartAlignment.spaceAround,
                                                                            chartStylingInfo:
                                                                                ChartStylingInfo(
                                                                              enableTooltip: true,
                                                                              tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                              backgroundColor: Colors.black,
                                                                              showBorder: false,
                                                                            ),
                                                                            axisBounds:
                                                                                AxisBounds(),
                                                                            xAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              showLabels: true,
                                                                              labelTextStyle: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                fontSize: 10,
                                                                              ),
                                                                              labelInterval: 10,
                                                                              reservedSize: 28,
                                                                            ),
                                                                            yAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              reservedSize: 0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 15,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Container(
                                                            width: 440,
                                                            height: 240,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF010101),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            5,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Ranking de Desempenho por Dia da Semana',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            fontSize:
                                                                                18,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  thickness: 2,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          VwAnalyticsDiaSemanaRow>>(
                                                                    future: VwAnalyticsDiaSemanaTable()
                                                                        .queryRows(
                                                                      queryFn: (q) => q
                                                                          .eqOrNull(
                                                                            'id_companhia',
                                                                            analyticsUsuariosRow?.idCompanhia,
                                                                          )
                                                                          .eqOrNull(
                                                                            'ano',
                                                                            FFAppState().AnoAnalytics,
                                                                          ),
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
                                                                      List<VwAnalyticsDiaSemanaRow>
                                                                          cTNGraficoVwAnalyticsDiaSemanaRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return Container(
                                                                        width:
                                                                            870,
                                                                        height:
                                                                            190,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              870,
                                                                          height:
                                                                              189,
                                                                          child:
                                                                              FlutterFlowBarChart(
                                                                            barData: [
                                                                              FFBarChartData(
                                                                                yData: cTNGraficoVwAnalyticsDiaSemanaRowList.map((e) => e.totalAtendimentos).withoutNulls.toList(),
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                              )
                                                                            ],
                                                                            xLabels:
                                                                                cTNGraficoVwAnalyticsDiaSemanaRowList.map((e) => e.diaSemana).withoutNulls.toList(),
                                                                            barWidth:
                                                                                10,
                                                                            barBorderRadius:
                                                                                BorderRadius.circular(8),
                                                                            groupSpace:
                                                                                30,
                                                                            alignment:
                                                                                BarChartAlignment.spaceAround,
                                                                            chartStylingInfo:
                                                                                ChartStylingInfo(
                                                                              enableTooltip: true,
                                                                              tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                              backgroundColor: Colors.black,
                                                                              showBorder: false,
                                                                            ),
                                                                            axisBounds:
                                                                                AxisBounds(),
                                                                            xAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              showLabels: true,
                                                                              labelTextStyle: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                fontSize: 10,
                                                                              ),
                                                                              labelInterval: 10,
                                                                              reservedSize: 28,
                                                                            ),
                                                                            yAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              reservedSize: 0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 10)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 10)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
