import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/d_gestao/descricao/descricao_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gestao/menu_gestao_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/a_colaborador/editar_colaborador/editar_colaborador_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/a_colaborador/novo_colaborador/novo_colaborador_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/b_procedimento/edicao_procedimento/edicao_procedimento_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/b_procedimento/novo_procedimento/novo_procedimento_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/c_anamnese/editar_pergunta/editar_pergunta_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/c_anamnese/nova_pergunta/nova_pergunta_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/conta_pagar/conta_pagar_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/d_contas_pagar/editar_conta_pagar/editar_conta_pagar_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/e_contas_receber/descricao_recebimento/descricao_recebimento_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/e_contas_receber/editar_recebido/editar_recebido_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/editar_geral/a_editar_estoque/a_editar_estoque_widget.dart';
import '/vision_smart_beauty/d_gestao/menu_gesto_geral/f_estoque/novo_produto/a_novo_estoque/a_novo_estoque_widget.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:convert';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'gestao_model.dart';
export 'gestao_model.dart';

class GestaoWidget extends StatefulWidget {
  const GestaoWidget({super.key});

  static String routeName = 'Gestao';
  static String routePath = '/Gestao';

  @override
  State<GestaoWidget> createState() => _GestaoWidgetState();
}

class _GestaoWidgetState extends State<GestaoWidget> {
  late GestaoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GestaoModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultwvq = await VerificareatualizarcontasCall.call();
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
        List<UsuariosRow> gestaoUsuariosRowList = snapshot.data!;

        final gestaoUsuariosRow = gestaoUsuariosRowList.isNotEmpty
            ? gestaoUsuariosRowList.first
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
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: FutureBuilder<List<CompanhiaRow>>(
                    future: CompanhiaTable().querySingleRow(
                      queryFn: (q) => q.eqOrNull(
                        'id',
                        gestaoUsuariosRow?.idCompanhia,
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
                        width: 1439.3,
                        height: 941.35,
                        decoration: BoxDecoration(),
                        alignment: AlignmentDirectional(0, 0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      MenuGestaoWidget(),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        },
                                                        child: Icon(
                                                          Icons.menu,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          size: 40,
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: RichText(
                                                          textScaler:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'Gestão - ',
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
                                                                      fontSize:
                                                                          22,
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
                                                                    valueOrDefault<
                                                                        String>(
                                                                  FFAppState()
                                                                      .gestaoMenu,
                                                                  'Gestão',
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
                                                                          .secondaryBackground,
                                                                      fontSize:
                                                                          22,
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
                                                                  fontSize: 14,
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
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 15)),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      if (FFAppState()
                                                              .gestaoMenu ==
                                                          'Contas a Pagar')
                                                        Container(
                                                          width:
                                                              double.infinity,
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
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  FlutterFlowDropDown<
                                                                      String>(
                                                                    controller: _model
                                                                            .anoPagarValueController ??=
                                                                        FormFieldController<
                                                                            String>(
                                                                      _model.anoPagarValue ??=
                                                                          _model
                                                                              .mesSelecionado,
                                                                    ),
                                                                    options: [
                                                                      '2025',
                                                                      '2026',
                                                                      '2027',
                                                                      '2028',
                                                                      '2029',
                                                                      '2030',
                                                                      '2031',
                                                                      '2032',
                                                                      '2033',
                                                                      '2034',
                                                                      '2035'
                                                                    ],
                                                                    onChanged:
                                                                        (val) async {
                                                                      safeSetState(() =>
                                                                          _model.anoPagarValue =
                                                                              val);
                                                                      _model.selectedYearPagar =
                                                                          functions
                                                                              .stringToInt(_model.anoPagarValue!);
                                                                      safeSetState(
                                                                          () {});
                                                                      _model.inicioAnoPagar =
                                                                          functions
                                                                              .yearToStartDate(_model.selectedYearPagar!);
                                                                      safeSetState(
                                                                          () {});
                                                                      _model.inicioProxAnoPagar =
                                                                          functions
                                                                              .yearToNextStartDate(_model.selectedYearPagar!);
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    width: 150,
                                                                    height: 30,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Ano',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      size: 17,
                                                                    ),
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    elevation:
                                                                        2,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                    borderWidth:
                                                                        0,
                                                                    borderRadius:
                                                                        8,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                    hidesUnderline:
                                                                        true,
                                                                    isOverButton:
                                                                        false,
                                                                    isSearchable:
                                                                        false,
                                                                    isMultiSelect:
                                                                        false,
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        FlutterFlowIconButton(
                                                                      borderRadius:
                                                                          8,
                                                                      buttonSize:
                                                                          35,
                                                                      fillColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .tertiary,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .restore_from_trash,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        size:
                                                                            17.5,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        safeSetState(
                                                                            () {
                                                                          _model
                                                                              .anoPagarValueController
                                                                              ?.reset();
                                                                          _model.anoPagarValue =
                                                                              null;
                                                                        });
                                                                        _model.selectedYearPagar =
                                                                            null;
                                                                        _model.inicioAnoPagar =
                                                                            null;
                                                                        _model.inicioProxAnoPagar =
                                                                            null;
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                    ),
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        width:
                                                                            5)),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  FlutterFlowDropDown<
                                                                      String>(
                                                                    controller: _model
                                                                            .mesPagarValueController ??=
                                                                        FormFieldController<
                                                                            String>(
                                                                      _model.mesPagarValue ??=
                                                                          _model
                                                                              .mesSelecionado,
                                                                    ),
                                                                    options: [
                                                                      'Janeiro',
                                                                      'Fevereiro',
                                                                      'Março',
                                                                      'Abril',
                                                                      'Maio',
                                                                      'Junho',
                                                                      'Julho',
                                                                      'Agosto',
                                                                      'Setembro',
                                                                      'Outubro',
                                                                      'Novembro',
                                                                      'Dezembro'
                                                                    ],
                                                                    onChanged:
                                                                        (val) async {
                                                                      safeSetState(() =>
                                                                          _model.mesPagarValue =
                                                                              val);
                                                                      _model.mesSelecionado =
                                                                          _model
                                                                              .mesPagarValue;
                                                                      safeSetState(
                                                                          () {});
                                                                      _model.inicioMes = functions.getFirstDayOfMonthFromName(
                                                                          _model
                                                                              .mesSelecionado!,
                                                                          _model
                                                                              .selectedYearPagar!);
                                                                      safeSetState(
                                                                          () {});
                                                                      _model.inicioProxMes = functions.getFirstDayOfNextMonthFromName(
                                                                          _model
                                                                              .mesSelecionado!,
                                                                          _model
                                                                              .selectedYearPagar!);
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    width: 150,
                                                                    height: 30,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Mês',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      size: 17,
                                                                    ),
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    elevation:
                                                                        2,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                    borderWidth:
                                                                        0,
                                                                    borderRadius:
                                                                        8,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                    hidesUnderline:
                                                                        true,
                                                                    isOverButton:
                                                                        false,
                                                                    isSearchable:
                                                                        false,
                                                                    isMultiSelect:
                                                                        false,
                                                                  ),
                                                                  FlutterFlowIconButton(
                                                                    borderRadius:
                                                                        8,
                                                                    buttonSize:
                                                                        35,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .restore_from_trash,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      size:
                                                                          17.5,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      safeSetState(
                                                                          () {
                                                                        _model
                                                                            .mesPagarValueController
                                                                            ?.reset();
                                                                        _model.mesPagarValue =
                                                                            null;
                                                                      });
                                                                      _model.mesSelecionado =
                                                                          null;
                                                                      _model.inicioMes =
                                                                          null;
                                                                      _model.inicioProxMes =
                                                                          null;
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        width:
                                                                            5)),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  FlutterFlowDropDown<
                                                                      String>(
                                                                    controller: _model
                                                                        .statusPagarValueController ??= FormFieldController<
                                                                            String>(
                                                                        null),
                                                                    options: [
                                                                      'Pago',
                                                                      'Pendente',
                                                                      'Atrasado'
                                                                    ],
                                                                    onChanged: (val) =>
                                                                        safeSetState(() =>
                                                                            _model.statusPagarValue =
                                                                                val),
                                                                    width: 150,
                                                                    height: 30,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Status',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      size: 17,
                                                                    ),
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    elevation:
                                                                        2,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                    borderWidth:
                                                                        0,
                                                                    borderRadius:
                                                                        8,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                    hidesUnderline:
                                                                        true,
                                                                    isOverButton:
                                                                        false,
                                                                    isSearchable:
                                                                        false,
                                                                    isMultiSelect:
                                                                        false,
                                                                  ),
                                                                  FlutterFlowIconButton(
                                                                    borderRadius:
                                                                        8,
                                                                    buttonSize:
                                                                        35,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .restore_from_trash,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      size:
                                                                          17.5,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      safeSetState(
                                                                          () {
                                                                        _model
                                                                            .statusPagarValueController
                                                                            ?.reset();
                                                                        _model.statusPagarValue =
                                                                            null;
                                                                      });
                                                                    },
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        width:
                                                                            5)),
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
                                                                          CategoriaRow>>(
                                                                    future: CategoriaTable()
                                                                        .queryRows(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'id_companhia',
                                                                        gestaoUsuariosRow
                                                                            ?.idCompanhia,
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
                                                                      List<CategoriaRow>
                                                                          categoriaPagarCategoriaRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return FlutterFlowDropDown<
                                                                          String>(
                                                                        controller: _model
                                                                            .categoriaPagarValueController ??= FormFieldController<
                                                                                String>(
                                                                            null),
                                                                        options: categoriaPagarCategoriaRowList
                                                                            .map((e) =>
                                                                                e.nome)
                                                                            .withoutNulls
                                                                            .toList()
                                                                            .sortedList(keyOf: (e) => e, desc: false)
                                                                            .unique((e) => e),
                                                                        onChanged:
                                                                            (val) async {
                                                                          safeSetState(() =>
                                                                              _model.categoriaPagarValue = val);
                                                                          _model.opcaoCategoria =
                                                                              await CategoriaTable().queryRows(
                                                                            queryFn: (q) =>
                                                                                q.eqOrNull(
                                                                              'Nome',
                                                                              _model.categoriaPagarValue,
                                                                            ),
                                                                          );
                                                                          _model.categoriaPagar = _model
                                                                              .opcaoCategoria
                                                                              ?.firstOrNull
                                                                              ?.id;
                                                                          safeSetState(
                                                                              () {});

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        width:
                                                                            245,
                                                                        height:
                                                                            30,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        hintText:
                                                                            'Selecione uma Categoria',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        elevation:
                                                                            2,
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        borderWidth:
                                                                            0,
                                                                        borderRadius:
                                                                            8,
                                                                        margin: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        hidesUnderline:
                                                                            true,
                                                                        isOverButton:
                                                                            false,
                                                                        isSearchable:
                                                                            false,
                                                                        isMultiSelect:
                                                                            false,
                                                                      );
                                                                    },
                                                                  ),
                                                                  FlutterFlowIconButton(
                                                                    borderRadius:
                                                                        8,
                                                                    buttonSize:
                                                                        35,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .restore_from_trash,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      size:
                                                                          17.5,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      safeSetState(
                                                                          () {
                                                                        _model
                                                                            .categoriaPagarValueController
                                                                            ?.reset();
                                                                        _model.categoriaPagarValue =
                                                                            null;
                                                                      });
                                                                      await Future
                                                                          .delayed(
                                                                        Duration(
                                                                          milliseconds:
                                                                              50,
                                                                        ),
                                                                      );
                                                                      _model.categoriaPagar =
                                                                          null;
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        width:
                                                                            5)),
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
                                                                          ItemFinanceiroRow>>(
                                                                    future: ItemFinanceiroTable()
                                                                        .queryRows(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'id_companhia',
                                                                        gestaoUsuariosRow
                                                                            ?.idCompanhia,
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
                                                                      List<ItemFinanceiroRow>
                                                                          itemPagarItemFinanceiroRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return FlutterFlowDropDown<
                                                                          String>(
                                                                        controller: _model
                                                                            .itemPagarValueController ??= FormFieldController<
                                                                                String>(
                                                                            null),
                                                                        options: itemPagarItemFinanceiroRowList
                                                                            .map((e) =>
                                                                                e.item)
                                                                            .withoutNulls
                                                                            .toList()
                                                                            .sortedList(keyOf: (e) => e, desc: false)
                                                                            .unique((e) => e),
                                                                        onChanged:
                                                                            (val) async {
                                                                          safeSetState(() =>
                                                                              _model.itemPagarValue = val);
                                                                          _model.opcaoItem =
                                                                              await ItemFinanceiroTable().queryRows(
                                                                            queryFn: (q) =>
                                                                                q.eqOrNull(
                                                                              'item',
                                                                              _model.itemPagarValue,
                                                                            ),
                                                                          );
                                                                          _model.itemPagar = _model
                                                                              .opcaoItem
                                                                              ?.firstOrNull
                                                                              ?.id;
                                                                          safeSetState(
                                                                              () {});

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        width:
                                                                            200,
                                                                        height:
                                                                            30,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        hintText:
                                                                            'Selecione um Item',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        elevation:
                                                                            2,
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        borderWidth:
                                                                            0,
                                                                        borderRadius:
                                                                            8,
                                                                        margin: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        hidesUnderline:
                                                                            true,
                                                                        isOverButton:
                                                                            false,
                                                                        isSearchable:
                                                                            false,
                                                                        isMultiSelect:
                                                                            false,
                                                                      );
                                                                    },
                                                                  ),
                                                                  FlutterFlowIconButton(
                                                                    borderRadius:
                                                                        8,
                                                                    buttonSize:
                                                                        35,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .restore_from_trash,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      size:
                                                                          17.5,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      safeSetState(
                                                                          () {
                                                                        _model
                                                                            .itemPagarValueController
                                                                            ?.reset();
                                                                        _model.itemPagarValue =
                                                                            null;
                                                                      });
                                                                      _model.itemPagar =
                                                                          null;
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        width:
                                                                            5)),
                                                              ),
                                                              if (FFAppState()
                                                                      .gestaoMenu ==
                                                                  'Contas a Pagar')
                                                                InkWell(
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
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      enableDrag:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            FocusScope.of(context).unfocus();
                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                MediaQuery.viewInsetsOf(context),
                                                                            child:
                                                                                ContaPagarWidget(),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        safeSetState(
                                                                            () {}));

                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        10,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          180,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .success,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children:
                                                                            [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Icon(
                                                                              Icons.add_circle_outline_outlined,
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              size: 20,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Novo Cadastro',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  fontSize: 16,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 8)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      if (FFAppState()
                                                              .gestaoMenu ==
                                                          'Conta a Receber')
                                                        FutureBuilder<
                                                            List<
                                                                ContaReceberRow>>(
                                                          future:
                                                              ContaReceberTable()
                                                                  .querySingleRow(
                                                            queryFn: (q) =>
                                                                q.eqOrNull(
                                                              'id_companhia',
                                                              gestaoUsuariosRow
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
                                                            List<ContaReceberRow>
                                                                cTNFiltroReceberContaReceberRowList =
                                                                snapshot.data!;

                                                            final cTNFiltroReceberContaReceberRow =
                                                                cTNFiltroReceberContaReceberRowList
                                                                        .isNotEmpty
                                                                    ? cTNFiltroReceberContaReceberRowList
                                                                        .first
                                                                    : null;

                                                            return Container(
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
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      FlutterFlowDropDown<
                                                                          String>(
                                                                        controller:
                                                                            _model.anoReceberValueController ??=
                                                                                FormFieldController<String>(
                                                                          _model.anoReceberValue ??=
                                                                              valueOrDefault<String>(
                                                                            _model.selectedYear?.toString(),
                                                                            'Ano',
                                                                          ),
                                                                        ),
                                                                        options: [
                                                                          '2025',
                                                                          '2026',
                                                                          '2027',
                                                                          '2028',
                                                                          '2029',
                                                                          '2030',
                                                                          '2031',
                                                                          '2032',
                                                                          '2033',
                                                                          '2034',
                                                                          '2035'
                                                                        ],
                                                                        onChanged:
                                                                            (val) async {
                                                                          safeSetState(() =>
                                                                              _model.anoReceberValue = val);
                                                                          _model.selectedYear =
                                                                              functions.stringToInt(_model.anoReceberValue!);
                                                                          safeSetState(
                                                                              () {});
                                                                          _model.inicioAno =
                                                                              functions.yearToStartDate(_model.selectedYear!);
                                                                          safeSetState(
                                                                              () {});
                                                                          _model.inicioProxAno =
                                                                              functions.yearToNextStartDate(_model.selectedYear!);
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            30,
                                                                        searchHintTextStyle:
                                                                            GoogleFonts.roboto(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                        searchTextStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        hintText:
                                                                            'Ano',
                                                                        searchHintText:
                                                                            'Buscar',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        elevation:
                                                                            2,
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        borderWidth:
                                                                            0,
                                                                        borderRadius:
                                                                            8,
                                                                        margin: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        hidesUnderline:
                                                                            true,
                                                                        isOverButton:
                                                                            false,
                                                                        isSearchable:
                                                                            true,
                                                                        isMultiSelect:
                                                                            false,
                                                                      ),
                                                                      FlutterFlowIconButton(
                                                                        borderRadius:
                                                                            8,
                                                                        buttonSize:
                                                                            35,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .restore_from_trash,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17.5,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          safeSetState(
                                                                              () {
                                                                            _model.anoReceberValueController?.reset();
                                                                            _model.anoReceberValue =
                                                                                null;
                                                                          });
                                                                          _model.selectedYear =
                                                                              null;
                                                                          _model.inicioAno =
                                                                              null;
                                                                          _model.inicioProxAno =
                                                                              null;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      FlutterFlowDropDown<
                                                                          String>(
                                                                        controller:
                                                                            _model.mesReceberValueController ??=
                                                                                FormFieldController<String>(
                                                                          _model.mesReceberValue ??=
                                                                              _model.mesSelecionado,
                                                                        ),
                                                                        options: [
                                                                          'Janeiro',
                                                                          'Fevereiro',
                                                                          'Março',
                                                                          'Abril',
                                                                          'Maio',
                                                                          'Junho',
                                                                          'Julho',
                                                                          'Agosto',
                                                                          'Setembro',
                                                                          'Outubro',
                                                                          'Novembro',
                                                                          'Dezembro'
                                                                        ],
                                                                        onChanged:
                                                                            (val) async {
                                                                          safeSetState(() =>
                                                                              _model.mesReceberValue = val);
                                                                          _model.mesSelecionado =
                                                                              _model.mesReceberValue;
                                                                          safeSetState(
                                                                              () {});
                                                                          _model.inicioMes = functions.getFirstDayOfMonthFromName(
                                                                              _model.mesSelecionado!,
                                                                              _model.selectedYear!);
                                                                          safeSetState(
                                                                              () {});
                                                                          _model.inicioProxMes = functions.getFirstDayOfNextMonthFromName(
                                                                              _model.mesSelecionado!,
                                                                              _model.selectedYear!);
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            30,
                                                                        searchHintTextStyle:
                                                                            GoogleFonts.roboto(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                        searchTextStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        hintText:
                                                                            'Mês',
                                                                        searchHintText:
                                                                            'Buscar',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        elevation:
                                                                            2,
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        borderWidth:
                                                                            0,
                                                                        borderRadius:
                                                                            8,
                                                                        margin: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        hidesUnderline:
                                                                            true,
                                                                        isOverButton:
                                                                            false,
                                                                        isSearchable:
                                                                            true,
                                                                        isMultiSelect:
                                                                            false,
                                                                      ),
                                                                      FlutterFlowIconButton(
                                                                        borderRadius:
                                                                            8,
                                                                        buttonSize:
                                                                            35,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .restore_from_trash,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17.5,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          safeSetState(
                                                                              () {
                                                                            _model.mesReceberValueController?.reset();
                                                                            _model.mesReceberValue =
                                                                                null;
                                                                          });
                                                                          _model.mesSelecionado =
                                                                              null;
                                                                          _model.inicioMes =
                                                                              null;
                                                                          _model.inicioProxMes =
                                                                              null;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      FlutterFlowDropDown<
                                                                          String>(
                                                                        controller: _model
                                                                            .statusReceberValueController ??= FormFieldController<
                                                                                String>(
                                                                            null),
                                                                        options: [
                                                                          'Pago',
                                                                          'Pendente',
                                                                          'Atrasado'
                                                                        ],
                                                                        onChanged:
                                                                            (val) =>
                                                                                safeSetState(() => _model.statusReceberValue = val),
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            30,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        hintText:
                                                                            'Status',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        elevation:
                                                                            2,
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        borderWidth:
                                                                            0,
                                                                        borderRadius:
                                                                            8,
                                                                        margin: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        hidesUnderline:
                                                                            true,
                                                                        isOverButton:
                                                                            false,
                                                                        isSearchable:
                                                                            false,
                                                                        isMultiSelect:
                                                                            false,
                                                                      ),
                                                                      FlutterFlowIconButton(
                                                                        borderRadius:
                                                                            8,
                                                                        buttonSize:
                                                                            35,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .restore_from_trash,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17.5,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          safeSetState(
                                                                              () {
                                                                            _model.statusReceberValueController?.reset();
                                                                            _model.statusReceberValue =
                                                                                null;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child: FutureBuilder<
                                                                            List<ProcedimentosRow>>(
                                                                          future:
                                                                              ProcedimentosTable().queryRows(
                                                                            queryFn: (q) =>
                                                                                q.eqOrNull(
                                                                              'id_companhia',
                                                                              gestaoUsuariosRow?.idCompanhia,
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
                                                                                  child: SpinKitFadingFour(
                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                    size: 50,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            List<ProcedimentosRow>
                                                                                categoriaReceberProcedimentosRowList =
                                                                                snapshot.data!;

                                                                            return FlutterFlowDropDown<int>(
                                                                              controller: _model.categoriaReceberValueController ??= FormFieldController<int>(
                                                                                _model.categoriaReceberValue ??= _model.categoriaReceber,
                                                                              ),
                                                                              options: List<int>.from(categoriaReceberProcedimentosRowList.map((e) => e.id).toList()),
                                                                              optionLabels: categoriaReceberProcedimentosRowList.map((e) => e.nome).withoutNulls.toList(),
                                                                              onChanged: (val) async {
                                                                                safeSetState(() => _model.categoriaReceberValue = val);
                                                                                _model.saidaReceber = await ContaReceberTable().queryRows(
                                                                                  queryFn: (q) => q
                                                                                      .eqOrNull(
                                                                                        'id_companhia',
                                                                                        gestaoUsuariosRow?.idCompanhia,
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'id_procedimento',
                                                                                        _model.categoriaReceberValue,
                                                                                      ),
                                                                                );
                                                                                _model.saidaReceber2 = await ProcedimentosTable().queryRows(
                                                                                  queryFn: (q) => q
                                                                                      .eqOrNull(
                                                                                        'id_companhia',
                                                                                        gestaoUsuariosRow?.idCompanhia,
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'id',
                                                                                        _model.saidaReceber?.firstOrNull?.idProcedimento,
                                                                                      ),
                                                                                );
                                                                                _model.categoriaReceber = _model.saidaReceber2?.firstOrNull?.id;
                                                                                safeSetState(() {});

                                                                                safeSetState(() {});
                                                                              },
                                                                              width: 227.7,
                                                                              height: 30,
                                                                              searchHintTextStyle: GoogleFonts.roboto(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                fontSize: 16,
                                                                              ),
                                                                              searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 16,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 14,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                              hintText: 'Selecione o procedimento',
                                                                              searchHintText: 'Buscar',
                                                                              icon: Icon(
                                                                                Icons.keyboard_arrow_down_rounded,
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                size: 17,
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
                                                                      ),
                                                                      FlutterFlowIconButton(
                                                                        borderRadius:
                                                                            8,
                                                                        buttonSize:
                                                                            35,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .restore_from_trash,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17.5,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          safeSetState(
                                                                              () {
                                                                            _model.categoriaReceberValueController?.reset();
                                                                            _model.categoriaReceberValue =
                                                                                null;
                                                                          });
                                                                          _model.categoriaReceber =
                                                                              null;
                                                                          safeSetState(
                                                                              () {});
                                                                          await Future
                                                                              .delayed(
                                                                            Duration(
                                                                              milliseconds: 10,
                                                                            ),
                                                                          );
                                                                          _model.categoriaReceber =
                                                                              null;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
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
                                                                              ClientesRow>>(
                                                                        future:
                                                                            ClientesTable().queryRows(
                                                                          queryFn: (q) =>
                                                                              q.eqOrNull(
                                                                            'id_companhia',
                                                                            gestaoUsuariosRow?.idCompanhia,
                                                                          ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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
                                                                          List<ClientesRow>
                                                                              itemReceberClientesRowList =
                                                                              snapshot.data!;

                                                                          return FlutterFlowDropDown<
                                                                              String>(
                                                                            controller: _model.itemReceberValueController ??=
                                                                                FormFieldController<String>(
                                                                              _model.itemReceberValue ??= cTNFiltroReceberContaReceberRow?.idCliente?.toString(),
                                                                            ),
                                                                            options: itemReceberClientesRowList
                                                                                .map((e) => valueOrDefault<String>(
                                                                                      e.nome,
                                                                                      'Nome',
                                                                                    ))
                                                                                .toList()
                                                                                .sortedList(keyOf: (e) => e, desc: false)
                                                                                .unique((e) => e),
                                                                            onChanged:
                                                                                (val) async {
                                                                              safeSetState(() => _model.itemReceberValue = val);
                                                                              _model.opcaoNome = await ClientesTable().queryRows(
                                                                                queryFn: (q) => q.eqOrNull(
                                                                                  'nome',
                                                                                  _model.itemReceberValue,
                                                                                ),
                                                                              );
                                                                              _model.itemReceber = _model.opcaoNome?.firstOrNull?.id;
                                                                              safeSetState(() {});

                                                                              safeSetState(() {});
                                                                            },
                                                                            width:
                                                                                215,
                                                                            height:
                                                                                30,
                                                                            searchHintTextStyle:
                                                                                GoogleFonts.roboto(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 16,
                                                                            ),
                                                                            searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  fontSize: 16,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  fontSize: 14,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                            hintText:
                                                                                'Selecione o cliente',
                                                                            searchHintText:
                                                                                'Buscar',
                                                                            icon:
                                                                                Icon(
                                                                              Icons.keyboard_arrow_down_rounded,
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              size: 17,
                                                                            ),
                                                                            fillColor:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            elevation:
                                                                                2,
                                                                            borderColor:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            borderWidth:
                                                                                0,
                                                                            borderRadius:
                                                                                8,
                                                                            margin: EdgeInsetsDirectional.fromSTEB(
                                                                                12,
                                                                                0,
                                                                                12,
                                                                                0),
                                                                            hidesUnderline:
                                                                                true,
                                                                            isOverButton:
                                                                                false,
                                                                            isSearchable:
                                                                                true,
                                                                            isMultiSelect:
                                                                                false,
                                                                          );
                                                                        },
                                                                      ),
                                                                      FlutterFlowIconButton(
                                                                        borderRadius:
                                                                            8,
                                                                        buttonSize:
                                                                            35,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .restore_from_trash,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17.5,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          safeSetState(
                                                                              () {
                                                                            _model.itemReceberValueController?.reset();
                                                                            _model.itemReceberValue =
                                                                                null;
                                                                          });
                                                                          _model.itemReceber =
                                                                              null;
                                                                          safeSetState(
                                                                              () {});
                                                                          await Future
                                                                              .delayed(
                                                                            Duration(
                                                                              milliseconds: 10,
                                                                            ),
                                                                          );
                                                                          _model.itemReceber =
                                                                              null;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      if (FFAppState()
                                                              .gestaoMenu ==
                                                          'Colaborador')
                                                        FutureBuilder<
                                                            List<UsuariosRow>>(
                                                          future:
                                                              UsuariosTable()
                                                                  .queryRows(
                                                            queryFn: (q) =>
                                                                q.eqOrNull(
                                                              'id_companhia',
                                                              gestaoUsuariosRow
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
                                                            List<UsuariosRow>
                                                                cTNFiltroColaboradorUsuariosRowList =
                                                                snapshot.data!;

                                                            return Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      FlutterFlowDropDown<
                                                                          String>(
                                                                        controller: _model
                                                                            .nomeColaboradorValueController ??= FormFieldController<
                                                                                String>(
                                                                            null),
                                                                        options: cTNFiltroColaboradorUsuariosRowList
                                                                            .map((e) =>
                                                                                e.nome)
                                                                            .withoutNulls
                                                                            .toList()
                                                                            .sortedList(keyOf: (e) => e, desc: false)
                                                                            .unique((e) => e),
                                                                        onChanged:
                                                                            (val) =>
                                                                                safeSetState(() => _model.nomeColaboradorValue = val),
                                                                        width:
                                                                            250,
                                                                        height:
                                                                            30,
                                                                        searchHintTextStyle:
                                                                            GoogleFonts.roboto(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                        searchTextStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        hintText:
                                                                            'Colaborador',
                                                                        searchHintText:
                                                                            'Buscar',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        elevation:
                                                                            2,
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        borderWidth:
                                                                            0,
                                                                        borderRadius:
                                                                            8,
                                                                        margin: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        hidesUnderline:
                                                                            true,
                                                                        isOverButton:
                                                                            false,
                                                                        isSearchable:
                                                                            true,
                                                                        isMultiSelect:
                                                                            false,
                                                                      ),
                                                                      FlutterFlowIconButton(
                                                                        borderRadius:
                                                                            8,
                                                                        buttonSize:
                                                                            35,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .restore_from_trash,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17.5,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          safeSetState(
                                                                              () {
                                                                            _model.nomeColaboradorValueController?.reset();
                                                                            _model.nomeColaboradorValue =
                                                                                null;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        'Acesso a Plataforma',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      FlutterFlowDropDown<
                                                                          bool>(
                                                                        controller:
                                                                            _model.acessoPlataformaValueController ??=
                                                                                FormFieldController<bool>(
                                                                          _model.acessoPlataformaValue ??=
                                                                              cTNFiltroColaboradorUsuariosRowList.firstOrNull?.acesso == true,
                                                                        ),
                                                                        options:
                                                                            List<bool>.from([
                                                                          true,
                                                                          false
                                                                        ]),
                                                                        optionLabels: [
                                                                          'Liberado',
                                                                          'Bloqueado'
                                                                        ],
                                                                        onChanged:
                                                                            (val) async {
                                                                          safeSetState(() =>
                                                                              _model.acessoPlataformaValue = val);
                                                                          _model.acesso =
                                                                              _model.acessoPlataformaValue;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        width:
                                                                            250,
                                                                        height:
                                                                            30,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        hintText:
                                                                            'Liberado',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        elevation:
                                                                            2,
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        borderWidth:
                                                                            0,
                                                                        borderRadius:
                                                                            8,
                                                                        margin: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        hidesUnderline:
                                                                            true,
                                                                        isOverButton:
                                                                            false,
                                                                        isSearchable:
                                                                            false,
                                                                        isMultiSelect:
                                                                            false,
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        enableDrag:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(context).unfocus();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                              child: NovoColaboradorWidget(
                                                                                urlCadastro: '',
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) =>
                                                                          safeSetState(
                                                                              () {}));

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          10,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            180,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).success,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                              child: Icon(
                                                                                Icons.add_circle_outline_outlined,
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                size: 20,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Novo Cadastro',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 16,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 8)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      if (FFAppState()
                                                              .gestaoMenu ==
                                                          'Procedimento')
                                                        FutureBuilder<
                                                            List<
                                                                ProcedimentosRow>>(
                                                          future:
                                                              ProcedimentosTable()
                                                                  .queryRows(
                                                            queryFn: (q) =>
                                                                q.eqOrNull(
                                                              'id_companhia',
                                                              gestaoUsuariosRow
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
                                                            List<ProcedimentosRow>
                                                                cTNFiltroProcedimentoProcedimentosRowList =
                                                                snapshot.data!;

                                                            return Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      FlutterFlowDropDown<
                                                                          String>(
                                                                        controller: _model
                                                                            .nomeProcedimentoValueController ??= FormFieldController<
                                                                                String>(
                                                                            null),
                                                                        options: cTNFiltroProcedimentoProcedimentosRowList
                                                                            .map((e) => e
                                                                                .nome)
                                                                            .withoutNulls
                                                                            .toList()
                                                                            .unique((e) =>
                                                                                e)
                                                                            .sortedList(
                                                                                keyOf: (e) => e,
                                                                                desc: false),
                                                                        onChanged:
                                                                            (val) =>
                                                                                safeSetState(() => _model.nomeProcedimentoValue = val),
                                                                        width:
                                                                            250,
                                                                        height:
                                                                            30,
                                                                        searchHintTextStyle:
                                                                            GoogleFonts.roboto(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                        searchTextStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        hintText:
                                                                            'Procedimento',
                                                                        searchHintText:
                                                                            'Buscar',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        elevation:
                                                                            2,
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        borderWidth:
                                                                            0,
                                                                        borderRadius:
                                                                            8,
                                                                        margin: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        hidesUnderline:
                                                                            true,
                                                                        isOverButton:
                                                                            false,
                                                                        isSearchable:
                                                                            true,
                                                                        isMultiSelect:
                                                                            false,
                                                                      ),
                                                                      FlutterFlowIconButton(
                                                                        borderRadius:
                                                                            8,
                                                                        buttonSize:
                                                                            35,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .restore_from_trash,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17.5,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          safeSetState(
                                                                              () {
                                                                            _model.nomeProcedimentoValueController?.reset();
                                                                            _model.nomeProcedimentoValue =
                                                                                null;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        enableDrag:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(context).unfocus();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                              child: NovoProcedimentoWidget(),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) =>
                                                                          safeSetState(
                                                                              () {}));

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          10,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            180,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).success,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children:
                                                                              [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                              child: Icon(
                                                                                Icons.add_circle_outline_outlined,
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                size: 20,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Novo Cadastro',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 16,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 8)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      if (FFAppState()
                                                              .gestaoMenu ==
                                                          'Anamnese')
                                                        FutureBuilder<
                                                            List<AnamneseRow>>(
                                                          future:
                                                              AnamneseTable()
                                                                  .queryRows(
                                                            queryFn: (q) =>
                                                                q.eqOrNull(
                                                              'id_companhia',
                                                              gestaoUsuariosRow
                                                                  ?.idCompanhia,
                                                            ),
                                                            limit: 20,
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
                                                            List<AnamneseRow>
                                                                cTNFiltroAnanmeseAnamneseRowList =
                                                                snapshot.data!;

                                                            return Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 40,
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
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      FlutterFlowDropDown<
                                                                          String>(
                                                                        controller: _model
                                                                            .nomeAnamneseValueController ??= FormFieldController<
                                                                                String>(
                                                                            null),
                                                                        options: cTNFiltroAnanmeseAnamneseRowList
                                                                            .map((e) =>
                                                                                e.pergunta)
                                                                            .withoutNulls
                                                                            .toList()
                                                                            .sortedList(keyOf: (e) => e, desc: false),
                                                                        onChanged:
                                                                            (val) =>
                                                                                safeSetState(() => _model.nomeAnamneseValue = val),
                                                                        width:
                                                                            800,
                                                                        height:
                                                                            30,
                                                                        searchHintTextStyle:
                                                                            GoogleFonts.roboto(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                        searchTextStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                        hintText:
                                                                            'Pergunta',
                                                                        searchHintText:
                                                                            'Buscar',
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                        elevation:
                                                                            2,
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        borderWidth:
                                                                            0,
                                                                        borderRadius:
                                                                            8,
                                                                        margin: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                        hidesUnderline:
                                                                            true,
                                                                        isOverButton:
                                                                            false,
                                                                        isSearchable:
                                                                            true,
                                                                        isMultiSelect:
                                                                            false,
                                                                      ),
                                                                      FlutterFlowIconButton(
                                                                        borderRadius:
                                                                            8,
                                                                        buttonSize:
                                                                            35,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).tertiary,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .restore_from_trash,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          size:
                                                                              17.5,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          safeSetState(
                                                                              () {
                                                                            _model.nomeAnamneseValueController?.reset();
                                                                            _model.nomeAnamneseValue =
                                                                                null;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                  if ((FFAppState()
                                                                              .gestaoMenu ==
                                                                          'Anamnese') &&
                                                                      (cTNFiltroAnanmeseAnamneseRowList
                                                                              .length <
                                                                          20))
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        await showModalBottomSheet(
                                                                          isScrollControlled:
                                                                              true,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          enableDrag:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(context).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: Padding(
                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                child: NovaPerguntaWidget(),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ).then((value) =>
                                                                            safeSetState(() {}));

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        elevation:
                                                                            10,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              180,
                                                                          height:
                                                                              30,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).success,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          child:
                                                                              Visibility(
                                                                            visible:
                                                                                (FFAppState().gestaoMenu == 'Anamnese') && (cTNFiltroAnanmeseAnamneseRowList.length < 20),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                                  child: Icon(
                                                                                    Icons.add_circle_outline_outlined,
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    size: 20,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  'Novo Cadastro',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        fontSize: 16,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 5)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      if (FFAppState()
                                                              .gestaoMenu ==
                                                          'Estoque')
                                                        FutureBuilder<
                                                            List<
                                                                VwEstoqueAtualRow>>(
                                                          future:
                                                              VwEstoqueAtualTable()
                                                                  .queryRows(
                                                            queryFn: (q) =>
                                                                q.eqOrNull(
                                                              'id_companhia',
                                                              gestaoUsuariosRow
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
                                                            List<VwEstoqueAtualRow>
                                                                cTNFiltroEstoqueVwEstoqueAtualRowList =
                                                                snapshot.data!;

                                                            return Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  FutureBuilder<
                                                                      List<
                                                                          ProdutosRow>>(
                                                                    future: ProdutosTable()
                                                                        .queryRows(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'id_companhia',
                                                                        gestaoUsuariosRow
                                                                            ?.idCompanhia,
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
                                                                      List<ProdutosRow>
                                                                          containerProdutosRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return Container(
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children:
                                                                              [
                                                                            FlutterFlowDropDown<int>(
                                                                              controller: _model.produtoValueController ??= FormFieldController<int>(null),
                                                                              options: List<int>.from(containerProdutosRowList.map((e) => e.id).toList()),
                                                                              optionLabels: containerProdutosRowList.map((e) => e.produtos).withoutNulls.toList(),
                                                                              onChanged: (val) async {
                                                                                safeSetState(() => _model.produtoValue = val);
                                                                                _model.filtroproduto = _model.produtoValue;
                                                                                safeSetState(() {});
                                                                              },
                                                                              width: 250,
                                                                              height: 30,
                                                                              searchHintTextStyle: GoogleFonts.roboto(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                fontSize: 14,
                                                                              ),
                                                                              searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 16,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 14,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                              hintText: 'Selecione um Produto',
                                                                              searchHintText: 'Buscar',
                                                                              icon: Icon(
                                                                                Icons.keyboard_arrow_down_rounded,
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                size: 17,
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
                                                                            ),
                                                                            FlutterFlowIconButton(
                                                                              borderRadius: 8,
                                                                              buttonSize: 35,
                                                                              fillColor: FlutterFlowTheme.of(context).tertiary,
                                                                              icon: Icon(
                                                                                Icons.restore_from_trash,
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                size: 17.5,
                                                                              ),
                                                                              onPressed: () async {
                                                                                safeSetState(() {
                                                                                  _model.produtoValueController?.reset();
                                                                                  _model.produtoValue = null;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ].divide(SizedBox(width: 5)),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        enableDrag:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(context).unfocus();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                              child: ANovoEstoqueWidget(),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) =>
                                                                          safeSetState(
                                                                              () {}));

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          10,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            180,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).success,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children:
                                                                              [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                              child: Icon(
                                                                                Icons.add_circle_outline_outlined,
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                size: 20,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Novo Cadastro',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 16,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 5)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        width:
                                                                            8)),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1800,
                                        child: Divider(
                                          thickness: 2,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 713.03,
                                        decoration: BoxDecoration(),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Stack(
                                            children: [
                                              if (FFAppState().gestaoMenu ==
                                                  'Colaborador')
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  child: SingleChildScrollView(
                                                    primary: false,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
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
                                                                Container(
                                                                  width: 270,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Nome Completo',
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
                                                                  width: 220,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'CPF',
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
                                                                  width: 270,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Email',
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
                                                                  width: 220,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Telefone',
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
                                                                  width: 120,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Acesso\nPlataforma',
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
                                                                  width: 125,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Acesso Administrativo',
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
                                                                  width: 100,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Editar',
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
                                                        ),
                                                        SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              FutureBuilder<
                                                                  List<
                                                                      UsuariosRow>>(
                                                                future:
                                                                    UsuariosTable()
                                                                        .queryRows(
                                                                  queryFn: (q) => q
                                                                      .eqOrNull(
                                                                        'id_companhia',
                                                                        gestaoUsuariosRow
                                                                            ?.idCompanhia,
                                                                      )
                                                                      .eqOrNull(
                                                                        'nome',
                                                                        _model
                                                                            .nomeColaboradorValue,
                                                                      )
                                                                      .eqOrNull(
                                                                        'acesso',
                                                                        _model
                                                                            .acesso,
                                                                      )
                                                                      .order('nome', ascending: true),
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
                                                                  List<UsuariosRow>
                                                                      listColaboradorUsuariosRowList =
                                                                      snapshot
                                                                          .data!;

                                                                  return ListView
                                                                      .separated(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        listColaboradorUsuariosRowList
                                                                            .length,
                                                                    separatorBuilder: (_,
                                                                            __) =>
                                                                        SizedBox(
                                                                            height:
                                                                                10),
                                                                    itemBuilder:
                                                                        (context,
                                                                            listColaboradorIndex) {
                                                                      final listColaboradorUsuariosRow =
                                                                          listColaboradorUsuariosRowList[
                                                                              listColaboradorIndex];
                                                                      return Container(
                                                                        height:
                                                                            50,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
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
                                                                              Container(
                                                                                width: 270,
                                                                                height: 50,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: Text(
                                                                                    valueOrDefault<String>(
                                                                                      listColaboradorUsuariosRow.nome,
                                                                                      'Nome',
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
                                                                              ),
                                                                              Container(
                                                                                width: 220,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: Text(
                                                                                    valueOrDefault<String>(
                                                                                      listColaboradorUsuariosRow.cpf,
                                                                                      'CPF',
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
                                                                              ),
                                                                              Container(
                                                                                width: 270,
                                                                                height: 50,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: Text(
                                                                                    valueOrDefault<String>(
                                                                                      listColaboradorUsuariosRow.email,
                                                                                      'Email',
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
                                                                              ),
                                                                              Container(
                                                                                width: 220,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: Text(
                                                                                    valueOrDefault<String>(
                                                                                      listColaboradorUsuariosRow.phone,
                                                                                      'Telefone',
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
                                                                              ),
                                                                              Container(
                                                                                width: 120,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: Text(
                                                                                    listColaboradorUsuariosRow.acesso == true ? 'Liberado' : 'Bloqueado',
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
                                                                              ),
                                                                              Container(
                                                                                width: 125,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: Text(
                                                                                    listColaboradorUsuariosRow.adm == true ? 'Liberado' : 'Bloqueado',
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
                                                                              ),
                                                                              Container(
                                                                                width: 100,
                                                                                height: 50,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: FlutterFlowIconButton(
                                                                                    borderRadius: 20,
                                                                                    buttonSize: 40,
                                                                                    fillColor: FlutterFlowTheme.of(context).success,
                                                                                    icon: FaIcon(
                                                                                      FontAwesomeIcons.penNib,
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
                                                                                          return GestureDetector(
                                                                                            onTap: () {
                                                                                              FocusScope.of(context).unfocus();
                                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                                            },
                                                                                            child: Padding(
                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                              child: EditarColaboradorWidget(
                                                                                                uidColaborador: listColaboradorUsuariosRow.id,
                                                                                                nome: listColaboradorUsuariosRow.nome!,
                                                                                                dataNascimento: listColaboradorUsuariosRow.dataNascimento!,
                                                                                                cpf: listColaboradorUsuariosRow.cpf!,
                                                                                                email: listColaboradorUsuariosRow.email!,
                                                                                                idColabaorador: listColaboradorUsuariosRow.id,
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      ).then((value) => safeSetState(() {}));
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              if (FFAppState().gestaoMenu ==
                                                  'Procedimento')
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 1380,
                                                          height: 616.6,
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
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          350,
                                                                      height:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          'Procedimento',
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
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          'Valor',
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
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          'Duração',
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
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          'Intervalo',
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
                                                                      width:
                                                                          150,
                                                                      height:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          'Esta sendo trabalhado?',
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
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        ' ',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                FutureBuilder<
                                                                    List<
                                                                        ProcedimentosRow>>(
                                                                  future: ProcedimentosTable()
                                                                      .queryRows(
                                                                    queryFn: (q) => q
                                                                        .eqOrNull(
                                                                          'id_companhia',
                                                                          gestaoUsuariosRow
                                                                              ?.idCompanhia,
                                                                        )
                                                                        .eqOrNull(
                                                                          'nome',
                                                                          _model
                                                                              .nomeProcedimentoValue,
                                                                        )
                                                                        .order('nome', ascending: true)
                                                                        .order('Trabalhado'),
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
                                                                    List<ProcedimentosRow>
                                                                        listViewProcedimentosRowList =
                                                                        snapshot
                                                                            .data!;

                                                                    return ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      primary:
                                                                          false,
                                                                      shrinkWrap:
                                                                          true,
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      itemCount:
                                                                          listViewProcedimentosRowList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              listViewIndex) {
                                                                        final listViewProcedimentosRow =
                                                                            listViewProcedimentosRowList[listViewIndex];
                                                                        return Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                50,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 350,
                                                                                    height: 100,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          listViewProcedimentosRow.nome,
                                                                                          'Procedimento',
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: listViewProcedimentosRow.trabalhado == true ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).error,
                                                                                              fontSize: 14,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 150,
                                                                                    height: 100,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          formatNumber(
                                                                                            listViewProcedimentosRow.valor,
                                                                                            formatType: FormatType.custom,
                                                                                            currency: 'R\$ ',
                                                                                            format: '#,##0.00',
                                                                                            locale: 'pt_BR',
                                                                                          ),
                                                                                          '0',
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: listViewProcedimentosRow.trabalhado == true ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).error,
                                                                                              fontSize: 14,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 150,
                                                                                    height: 100,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          '${valueOrDefault<String>(
                                                                                            listViewProcedimentosRow.duracao?.toString(),
                                                                                            '00',
                                                                                          )} Min',
                                                                                          '00',
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: listViewProcedimentosRow.trabalhado == true ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).error,
                                                                                              fontSize: 14,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0, 0),
                                                                                    child: Container(
                                                                                      width: 150,
                                                                                      height: 100,
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                        child: RichText(
                                                                                          textScaler: MediaQuery.of(context).textScaler,
                                                                                          text: TextSpan(
                                                                                            children: [
                                                                                              TextSpan(
                                                                                                text: valueOrDefault<String>(
                                                                                                  listViewProcedimentosRow.intervalo?.toString(),
                                                                                                  '00',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.inter(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: listViewProcedimentosRow.trabalhado == true ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).error,
                                                                                                      fontSize: 16,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                              TextSpan(
                                                                                                text: ' dias',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.inter(
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: listViewProcedimentosRow.trabalhado == true ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).error,
                                                                                                      fontSize: 16,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              )
                                                                                            ],
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.inter(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: listViewProcedimentosRow.trabalhado == true ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).error,
                                                                                                  fontSize: 14,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 150,
                                                                                    height: 100,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        listViewProcedimentosRow.trabalhado == true ? 'Sendo Trabalhado' : 'Não esta sendo trabalhado',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: listViewProcedimentosRow.trabalhado == true ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).error,
                                                                                              fontSize: 14,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0, 0),
                                                                                    child: Container(
                                                                                      width: 100,
                                                                                      height: 100,
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                        child: FlutterFlowIconButton(
                                                                                          borderRadius: 20,
                                                                                          buttonSize: 40,
                                                                                          fillColor: FlutterFlowTheme.of(context).success,
                                                                                          icon: FaIcon(
                                                                                            FontAwesomeIcons.penNib,
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
                                                                                                return GestureDetector(
                                                                                                  onTap: () {
                                                                                                    FocusScope.of(context).unfocus();
                                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                                  },
                                                                                                  child: Padding(
                                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                                    child: EdicaoProcedimentoWidget(
                                                                                                      idProcedimento: listViewProcedimentosRow.id,
                                                                                                      editarProcedimento: listViewProcedimentosRow.nome!,
                                                                                                      editarValor: listViewProcedimentosRow.valor!,
                                                                                                      editarIntervalo: listViewProcedimentosRow.intervalo,
                                                                                                      editarTrabalhar: listViewProcedimentosRow.trabalhado!,
                                                                                                      editarDuracao: listViewProcedimentosRow.duracao!,
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            ).then((value) => safeSetState(() {}));
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (FFAppState().gestaoMenu ==
                                                  'Anamnese')
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  child: SingleChildScrollView(
                                                    primary: false,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        10,
                                                                        0,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              5,
                                                                              0,
                                                                              10),
                                                                          child:
                                                                              Text(
                                                                            'Questionário de Anamnese',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  fontSize: 18,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ]
                                                                  .divide(
                                                                      SizedBox(
                                                                          width:
                                                                              1))
                                                                  .around(
                                                                      SizedBox(
                                                                          width:
                                                                              1)),
                                                            ),
                                                          ),
                                                        ),
                                                        ListView(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Container(
                                                                  width: 800,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child: Text(
                                                                    'Pergunta',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                          fontSize:
                                                                              16,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: 400,
                                                                    height: 30,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1,
                                                                            0),
                                                                    child: Text(
                                                                      'Caso seja necessário complementar a pergunta',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
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
                                                                                FlutterFlowTheme.of(context).tertiary,
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
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 3)),
                                                            ),
                                                            FutureBuilder<
                                                                List<
                                                                    AnamneseRow>>(
                                                              future:
                                                                  AnamneseTable()
                                                                      .queryRows(
                                                                queryFn: (q) =>
                                                                    q
                                                                        .eqOrNull(
                                                                          'id_companhia',
                                                                          gestaoUsuariosRow
                                                                              ?.idCompanhia,
                                                                        )
                                                                        .eqOrNull(
                                                                          'pergunta',
                                                                          _model
                                                                              .nomeAnamneseValue,
                                                                        )
                                                                        .order(
                                                                            'id',
                                                                            ascending:
                                                                                true),
                                                                limit: 20,
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
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          SpinKitFadingFour(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                        size:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<AnamneseRow>
                                                                    columnAnamneseRowList =
                                                                    snapshot
                                                                        .data!;

                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: List.generate(
                                                                      columnAnamneseRowList
                                                                          .length,
                                                                      (columnIndex) {
                                                                    final columnAnamneseRow =
                                                                        columnAnamneseRowList[
                                                                            columnIndex];
                                                                    return Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children:
                                                                            [
                                                                          Container(
                                                                            width:
                                                                                800,
                                                                            height:
                                                                                50,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            alignment:
                                                                                AlignmentDirectional(-1, 0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                columnAnamneseRow.pergunta,
                                                                                'Pergunta',
                                                                              ),
                                                                              textAlign: TextAlign.start,
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
                                                                            alignment:
                                                                                AlignmentDirectional(-1, 0),
                                                                            child:
                                                                                Container(
                                                                              width: 400,
                                                                              height: 50,
                                                                              decoration: BoxDecoration(),
                                                                              alignment: AlignmentDirectional(-1, 0),
                                                                              child: Text(
                                                                                valueOrDefault<String>(
                                                                                  columnAnamneseRow.casoSim,
                                                                                  'Qual(is)?',
                                                                                ),
                                                                                textAlign: TextAlign.start,
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
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1, 0),
                                                                            child:
                                                                                Container(
                                                                              width: 40,
                                                                              height: 40,
                                                                              decoration: BoxDecoration(),
                                                                              child: FlutterFlowIconButton(
                                                                                borderRadius: 20,
                                                                                buttonSize: 40,
                                                                                fillColor: FlutterFlowTheme.of(context).success,
                                                                                icon: FaIcon(
                                                                                  FontAwesomeIcons.penNib,
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
                                                                                      return GestureDetector(
                                                                                        onTap: () {
                                                                                          FocusScope.of(context).unfocus();
                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                        },
                                                                                        child: Padding(
                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                          child: EditarPerguntaWidget(
                                                                                            idPergunta: columnAnamneseRow.id,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ).then((value) => safeSetState(() {}));
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 3)),
                                                                      ),
                                                                    );
                                                                  }).divide(
                                                                      SizedBox(
                                                                          height:
                                                                              10)),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 15)),
                                                    ),
                                                  ),
                                                ),
                                              if (FFAppState().gestaoMenu ==
                                                  'Contas a Pagar')
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  child: SingleChildScrollView(
                                                    primary: false,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        0,
                                                                        10,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Container(
                                                                  width: 170,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Row(
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
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              FutureBuilder<List<ContaPagarRow>>(
                                                                                future: ContaPagarTable().queryRows(
                                                                                  queryFn: (q) => q
                                                                                      .eqOrNull(
                                                                                        'id_companhia',
                                                                                        gestaoUsuariosRow?.idCompanhia,
                                                                                      )
                                                                                      .gteOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioMes),
                                                                                      )
                                                                                      .ltOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioProxMes),
                                                                                      )
                                                                                      .gteOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioAnoPagar),
                                                                                      )
                                                                                      .ltOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioProxAnoPagar),
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'Status',
                                                                                        'Pago',
                                                                                      )
                                                                                      .order('data_operacao'),
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
                                                                                  List<ContaPagarRow> totalPagoContaPagarRowList = snapshot.data!;

                                                                                  return RichText(
                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                    text: TextSpan(
                                                                                      children: [
                                                                                        TextSpan(
                                                                                          text: 'Total Pago: ',
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
                                                                                        TextSpan(
                                                                                          text: valueOrDefault<String>(
                                                                                            functions.somarValores(totalPagoContaPagarRowList.map((e) => e.valor).withoutNulls.toList()),
                                                                                            'R\$ 0,00',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                                                fontSize: 12,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        )
                                                                                      ],
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    textAlign: TextAlign.start,
                                                                                  );
                                                                                },
                                                                              ),
                                                                              FutureBuilder<List<ContaPagarRow>>(
                                                                                future: ContaPagarTable().queryRows(
                                                                                  queryFn: (q) => q
                                                                                      .eqOrNull(
                                                                                        'id_companhia',
                                                                                        gestaoUsuariosRow?.idCompanhia,
                                                                                      )
                                                                                      .gteOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioMes),
                                                                                      )
                                                                                      .ltOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioProxMes),
                                                                                      )
                                                                                      .gteOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioAnoPagar),
                                                                                      )
                                                                                      .ltOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioProxAnoPagar),
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'Status',
                                                                                        'Pendente',
                                                                                      )
                                                                                      .order('data_operacao'),
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
                                                                                  List<ContaPagarRow> totalAPagarContaPagarRowList = snapshot.data!;

                                                                                  return RichText(
                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                    text: TextSpan(
                                                                                      children: [
                                                                                        TextSpan(
                                                                                          text: 'Total a Pagar: ',
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
                                                                                        TextSpan(
                                                                                          text: valueOrDefault<String>(
                                                                                            functions.somarValores(totalAPagarContaPagarRowList.map((e) => e.valor).withoutNulls.toList()),
                                                                                            'R\$ 0,00',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).warning,
                                                                                                fontSize: 12,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        )
                                                                                      ],
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            fontSize: 11,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                              FutureBuilder<List<ContaPagarRow>>(
                                                                                future: ContaPagarTable().queryRows(
                                                                                  queryFn: (q) => q
                                                                                      .eqOrNull(
                                                                                        'id_companhia',
                                                                                        gestaoUsuariosRow?.idCompanhia,
                                                                                      )
                                                                                      .gteOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioMes),
                                                                                      )
                                                                                      .ltOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioProxMes),
                                                                                      )
                                                                                      .gteOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioAnoPagar),
                                                                                      )
                                                                                      .ltOrNull(
                                                                                        'data_operacao',
                                                                                        supaSerialize<DateTime>(_model.inicioProxAnoPagar),
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'Status',
                                                                                        'Atrasado',
                                                                                      )
                                                                                      .order('data_operacao'),
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
                                                                                  List<ContaPagarRow> totalAtrasadoContaPagarRowList = snapshot.data!;

                                                                                  return RichText(
                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                    text: TextSpan(
                                                                                      children: [
                                                                                        TextSpan(
                                                                                          text: 'Total Atrasado: ',
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
                                                                                        TextSpan(
                                                                                          text: valueOrDefault<String>(
                                                                                            functions.somarValores(totalAtrasadoContaPagarRowList.map((e) => e.valor).withoutNulls.toList()),
                                                                                            'R\$ 0,00',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                                fontSize: 12,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        )
                                                                                      ],
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            fontSize: 11,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 10)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 270,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Data do Vencimento',
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
                                                                  width: 220,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Categoria',
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
                                                                  width: 270,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Item',
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
                                                                  width: 220,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Valor',
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
                                                                  width: 100,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Descrição',
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
                                                                  width: 60,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Editar',
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
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      5, 0, 0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  FutureBuilder<
                                                                      List<
                                                                          ContaPagarRow>>(
                                                                    future: ContaPagarTable()
                                                                        .queryRows(
                                                                      queryFn: (q) => q
                                                                          .eqOrNull(
                                                                            'id_companhia',
                                                                            gestaoUsuariosRow?.idCompanhia,
                                                                          )
                                                                          .gteOrNull(
                                                                            'data_operacao',
                                                                            supaSerialize<DateTime>(_model.inicioMes),
                                                                          )
                                                                          .ltOrNull(
                                                                            'data_operacao',
                                                                            supaSerialize<DateTime>(_model.inicioProxMes),
                                                                          )
                                                                          .eqOrNull(
                                                                            'id_categoria',
                                                                            _model.categoriaPagar,
                                                                          )
                                                                          .eqOrNull(
                                                                            'id_item',
                                                                            _model.itemPagar,
                                                                          )
                                                                          .gteOrNull(
                                                                            'data_operacao',
                                                                            supaSerialize<DateTime>(_model.inicioAnoPagar),
                                                                          )
                                                                          .ltOrNull(
                                                                            'data_operacao',
                                                                            supaSerialize<DateTime>(_model.inicioProxAnoPagar),
                                                                          )
                                                                          .eqOrNull(
                                                                            'Status',
                                                                            _model.statusPagarValue,
                                                                          )
                                                                          .order('data_operacao'),
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
                                                                      List<ContaPagarRow>
                                                                          listFinanceiroContaPagarRowList =
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
                                                                            listFinanceiroContaPagarRowList.length,
                                                                        separatorBuilder:
                                                                            (_, __) =>
                                                                                SizedBox(height: 10),
                                                                        itemBuilder:
                                                                            (context,
                                                                                listFinanceiroIndex) {
                                                                          final listFinanceiroContaPagarRow =
                                                                              listFinanceiroContaPagarRowList[listFinanceiroIndex];
                                                                          return FutureBuilder<
                                                                              List<CategoriaRow>>(
                                                                            future:
                                                                                CategoriaTable().querySingleRow(
                                                                              queryFn: (q) => q
                                                                                  .eqOrNull(
                                                                                    'id_companhia',
                                                                                    gestaoUsuariosRow?.idCompanhia,
                                                                                  )
                                                                                  .eqOrNull(
                                                                                    'id',
                                                                                    listFinanceiroContaPagarRow.idCategoria,
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
                                                                                    child: SpinKitFadingFour(
                                                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                                                      size: 50,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }
                                                                              List<CategoriaRow> containerCategoriaRowList = snapshot.data!;

                                                                              final containerCategoriaRow = containerCategoriaRowList.isNotEmpty ? containerCategoriaRowList.first : null;

                                                                              return Container(
                                                                                height: 50,
                                                                                decoration: BoxDecoration(),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                                                                  child: FutureBuilder<List<ItemFinanceiroRow>>(
                                                                                    future: ItemFinanceiroTable().querySingleRow(
                                                                                      queryFn: (q) => q
                                                                                          .eqOrNull(
                                                                                            'id_companhia',
                                                                                            gestaoUsuariosRow?.idCompanhia,
                                                                                          )
                                                                                          .eqOrNull(
                                                                                            'id',
                                                                                            listFinanceiroContaPagarRow.idItem,
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
                                                                                      List<ItemFinanceiroRow> rowItemFinanceiroRowList = snapshot.data!;

                                                                                      final rowItemFinanceiroRow = rowItemFinanceiroRowList.isNotEmpty ? rowItemFinanceiroRowList.first : null;

                                                                                      return Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 10,
                                                                                            height: 50,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  height: 100,
                                                                                                  child: VerticalDivider(
                                                                                                    thickness: 2,
                                                                                                    color: () {
                                                                                                      if (listFinanceiroContaPagarRow.status == 'Pago') {
                                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                                      } else if (listFinanceiroContaPagarRow.status == 'Pendente') {
                                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                                      } else {
                                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: 150,
                                                                                            height: 50,
                                                                                            decoration: BoxDecoration(),
                                                                                            alignment: AlignmentDirectional(0, 0),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                listFinanceiroContaPagarRow.status,
                                                                                                'Status',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: () {
                                                                                                      if (listFinanceiroContaPagarRow.status == 'Pago') {
                                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                                      } else if (listFinanceiroContaPagarRow.status == 'Pendente') {
                                                                                                        return FlutterFlowTheme.of(context).warning;
                                                                                                      } else {
                                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                                      }
                                                                                                    }(),
                                                                                                    fontSize: 16,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: 270,
                                                                                            height: 50,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0, 0),
                                                                                              child: Text(
                                                                                                valueOrDefault<String>(
                                                                                                  dateTimeFormat(
                                                                                                    "dd/MM/yyyy",
                                                                                                    listFinanceiroContaPagarRow.dataOperacao,
                                                                                                    locale: FFLocalizations.of(context).languageCode,
                                                                                                  ),
                                                                                                  'Vencimento',
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
                                                                                          ),
                                                                                          Container(
                                                                                            width: 220,
                                                                                            height: 30,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0, 0),
                                                                                              child: Text(
                                                                                                valueOrDefault<String>(
                                                                                                  containerCategoriaRow?.nome,
                                                                                                  'Categoria',
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
                                                                                          ),
                                                                                          Container(
                                                                                            width: 270,
                                                                                            height: 50,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0, 0),
                                                                                              child: Text(
                                                                                                valueOrDefault<String>(
                                                                                                  rowItemFinanceiroRow?.item,
                                                                                                  'Item',
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
                                                                                          ),
                                                                                          Container(
                                                                                            width: 220,
                                                                                            height: 30,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0, 0),
                                                                                              child: Text(
                                                                                                formatNumber(
                                                                                                  listFinanceiroContaPagarRow.valor!,
                                                                                                  formatType: FormatType.custom,
                                                                                                  currency: 'R\$ ',
                                                                                                  format: '#,###.##',
                                                                                                  locale: 'pt_BR',
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
                                                                                          ),
                                                                                          Container(
                                                                                            width: 100,
                                                                                            height: 50,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0, 0),
                                                                                              child: FlutterFlowIconButton(
                                                                                                borderRadius: 20,
                                                                                                buttonSize: 40,
                                                                                                fillColor: FlutterFlowTheme.of(context).tertiary,
                                                                                                icon: Icon(
                                                                                                  Icons.search,
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
                                                                                                      return GestureDetector(
                                                                                                        onTap: () {
                                                                                                          FocusScope.of(context).unfocus();
                                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                                        },
                                                                                                        child: Padding(
                                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                                          child: DescricaoWidget(
                                                                                                            idFinanceiro: listFinanceiroContaPagarRow.id,
                                                                                                            categoria: containerCategoriaRow!.id.toString(),
                                                                                                            item: rowItemFinanceiroRow!.id.toString(),
                                                                                                            valor: listFinanceiroContaPagarRow.valor!,
                                                                                                            dataCompra: listFinanceiroContaPagarRow.dataOperacao!,
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ).then((value) => safeSetState(() {}));
                                                                                                },
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: 60,
                                                                                            height: 50,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0, 0),
                                                                                              child: FlutterFlowIconButton(
                                                                                                borderRadius: 20,
                                                                                                buttonSize: 40,
                                                                                                fillColor: FlutterFlowTheme.of(context).success,
                                                                                                icon: FaIcon(
                                                                                                  FontAwesomeIcons.penNib,
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
                                                                                                      return GestureDetector(
                                                                                                        onTap: () {
                                                                                                          FocusScope.of(context).unfocus();
                                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                                        },
                                                                                                        child: Padding(
                                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                                          child: EditarContaPagarWidget(
                                                                                                            idFinanceiro: listFinanceiroContaPagarRow.id,
                                                                                                            categoria: containerCategoriaRow!.nome!,
                                                                                                            item: rowItemFinanceiroRow!.item!,
                                                                                                            valor: listFinanceiroContaPagarRow.valor!,
                                                                                                            dataCompra: listFinanceiroContaPagarRow.dataOperacao!,
                                                                                                            emissao: listFinanceiroContaPagarRow.dataEmissao!,
                                                                                                            tipoPagamento: listFinanceiroContaPagarRow.tipoPagamento!,
                                                                                                            status: listFinanceiroContaPagarRow.status!,
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ).then((value) => safeSetState(() {}));
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
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              if (FFAppState().gestaoMenu ==
                                                  'Conta a Receber')
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  child: SingleChildScrollView(
                                                    primary: false,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Padding(
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
                                                                      .spaceAround,
                                                              children: [
                                                                Container(
                                                                  width: 170,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            FutureBuilder<List<ContaReceberRow>>(
                                                                              future: ContaReceberTable().queryRows(
                                                                                queryFn: (q) => q
                                                                                    .eqOrNull(
                                                                                      'id_companhia',
                                                                                      gestaoUsuariosRow?.idCompanhia,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'status_financeiro',
                                                                                      'Pago',
                                                                                    )
                                                                                    .gteOrNull(
                                                                                      'Data_Vencimento',
                                                                                      supaSerialize<DateTime>(_model.inicioMes),
                                                                                    )
                                                                                    .ltOrNull(
                                                                                      'Data_Vencimento',
                                                                                      supaSerialize<DateTime>(_model.inicioProxMes),
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
                                                                                List<ContaReceberRow> totalRecebidoContaReceberRowList = snapshot.data!;

                                                                                return RichText(
                                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                                  text: TextSpan(
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: 'Total Recebido: ',
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
                                                                                      TextSpan(
                                                                                        text: valueOrDefault<String>(
                                                                                          functions.somarValores(totalRecebidoContaReceberRowList.map((e) => e.valorProcediemtno).withoutNulls.toList()),
                                                                                          'R\$ 0,00',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                                              fontSize: 12,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      )
                                                                                    ],
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            FutureBuilder<List<ContaReceberRow>>(
                                                                              future: ContaReceberTable().queryRows(
                                                                                queryFn: (q) => q
                                                                                    .eqOrNull(
                                                                                      'id_companhia',
                                                                                      gestaoUsuariosRow?.idCompanhia,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'status_financeiro',
                                                                                      'Pendente',
                                                                                    )
                                                                                    .gteOrNull(
                                                                                      'Data_Vencimento',
                                                                                      supaSerialize<DateTime>(_model.inicioMes),
                                                                                    )
                                                                                    .ltOrNull(
                                                                                      'Data_Vencimento',
                                                                                      supaSerialize<DateTime>(_model.inicioProxMes),
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
                                                                                List<ContaReceberRow> totalPendenteContaReceberRowList = snapshot.data!;

                                                                                return RichText(
                                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                                  text: TextSpan(
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: 'Total Pendente: ',
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
                                                                                      TextSpan(
                                                                                        text: valueOrDefault<String>(
                                                                                          functions.somarValores(totalPendenteContaReceberRowList.map((e) => e.valorProcediemtno).withoutNulls.toList()),
                                                                                          'R\$ 0,00',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                                              fontSize: 12,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      )
                                                                                    ],
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          fontSize: 11,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            FutureBuilder<List<ContaReceberRow>>(
                                                                              future: ContaReceberTable().queryRows(
                                                                                queryFn: (q) => q
                                                                                    .eqOrNull(
                                                                                      'id_companhia',
                                                                                      gestaoUsuariosRow?.idCompanhia,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'status_financeiro',
                                                                                      'Atrasado',
                                                                                    )
                                                                                    .gteOrNull(
                                                                                      'Data_Vencimento',
                                                                                      supaSerialize<DateTime>(_model.inicioMes),
                                                                                    )
                                                                                    .ltOrNull(
                                                                                      'Data_Vencimento',
                                                                                      supaSerialize<DateTime>(_model.inicioProxMes),
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
                                                                                List<ContaReceberRow> totalAtrasadoContaReceberRowList = snapshot.data!;

                                                                                return RichText(
                                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                                  text: TextSpan(
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: 'Total Atrasado:  ',
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
                                                                                      TextSpan(
                                                                                        text: valueOrDefault<String>(
                                                                                          functions.somarValores(totalAtrasadoContaReceberRowList.map((e) => e.valorProcediemtno).withoutNulls.toList()),
                                                                                          'R\$ 0,00',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).error,
                                                                                              fontSize: 12,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      )
                                                                                    ],
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          fontSize: 11,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            10)),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 270,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Data do Vencimento',
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
                                                                  width: 220,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Procedimento',
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
                                                                  width: 270,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Cliente',
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
                                                                  width: 220,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Valor',
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
                                                                  width: 100,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Descrição',
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
                                                                  width: 60,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Editar',
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
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      5, 0, 0),
                                                          child: Container(
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
                                                                          ContaReceberRow>>(
                                                                    future: ContaReceberTable()
                                                                        .queryRows(
                                                                      queryFn: (q) => q
                                                                          .eqOrNull(
                                                                            'id_companhia',
                                                                            gestaoUsuariosRow?.idCompanhia,
                                                                          )
                                                                          .eqOrNull(
                                                                            'id_procedimento',
                                                                            _model.categoriaReceber,
                                                                          )
                                                                          .eqOrNull(
                                                                            'id_cliente',
                                                                            _model.itemReceber,
                                                                          )
                                                                          .gteOrNull(
                                                                            'Data_Vencimento',
                                                                            supaSerialize<DateTime>(_model.inicioMes),
                                                                          )
                                                                          .ltOrNull(
                                                                            'Data_Vencimento',
                                                                            supaSerialize<DateTime>(_model.inicioProxMes),
                                                                          )
                                                                          .gteOrNull(
                                                                            'Data_Vencimento',
                                                                            supaSerialize<DateTime>(_model.inicioAno),
                                                                          )
                                                                          .ltOrNull(
                                                                            'Data_Vencimento',
                                                                            supaSerialize<DateTime>(_model.inicioProxAno),
                                                                          )
                                                                          .eqOrNull(
                                                                            'status_financeiro',
                                                                            _model.statusReceberValue,
                                                                          )
                                                                          .order('Data_Vencimento'),
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
                                                                      List<ContaReceberRow>
                                                                          listReceberContaReceberRowList =
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
                                                                            listReceberContaReceberRowList.length,
                                                                        separatorBuilder:
                                                                            (_, __) =>
                                                                                SizedBox(height: 10),
                                                                        itemBuilder:
                                                                            (context,
                                                                                listReceberIndex) {
                                                                          final listReceberContaReceberRow =
                                                                              listReceberContaReceberRowList[listReceberIndex];
                                                                          return Container(
                                                                            height:
                                                                                50,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 10,
                                                                                    height: 50,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          height: 100,
                                                                                          child: VerticalDivider(
                                                                                            thickness: 2,
                                                                                            color: () {
                                                                                              if (listReceberContaReceberRow.statusFinanceiro == 'Pago') {
                                                                                                return FlutterFlowTheme.of(context).success;
                                                                                              } else if (listReceberContaReceberRow.statusFinanceiro == 'Pendente') {
                                                                                                return FlutterFlowTheme.of(context).warning;
                                                                                              } else if (listReceberContaReceberRow.statusFinanceiro == 'Atrasado') {
                                                                                                return FlutterFlowTheme.of(context).error;
                                                                                              } else {
                                                                                                return FlutterFlowTheme.of(context).secondaryBackground;
                                                                                              }
                                                                                            }(),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 137.7,
                                                                                    height: 50,
                                                                                    decoration: BoxDecoration(),
                                                                                    alignment: AlignmentDirectional(0, 0),
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        listReceberContaReceberRow.statusFinanceiro,
                                                                                        'Status',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: () {
                                                                                              if (listReceberContaReceberRow.statusFinanceiro == 'Pago') {
                                                                                                return FlutterFlowTheme.of(context).success;
                                                                                              } else if (listReceberContaReceberRow.statusFinanceiro == 'Pendente') {
                                                                                                return FlutterFlowTheme.of(context).warning;
                                                                                              } else if (listReceberContaReceberRow.statusFinanceiro == 'Atrasado') {
                                                                                                return FlutterFlowTheme.of(context).error;
                                                                                              } else {
                                                                                                return FlutterFlowTheme.of(context).secondaryBackground;
                                                                                              }
                                                                                            }(),
                                                                                            fontSize: 16,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 270,
                                                                                    height: 50,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          dateTimeFormat(
                                                                                            "dd/MM/yyyy",
                                                                                            listReceberContaReceberRow.dataVencimento,
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ),
                                                                                          'Vencimento',
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              fontSize: 12,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 220,
                                                                                    height: 30,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: FutureBuilder<List<ProcedimentosRow>>(
                                                                                        future: ProcedimentosTable().queryRows(
                                                                                          queryFn: (q) => q.eqOrNull(
                                                                                            'id',
                                                                                            listReceberContaReceberRow.idProcedimento,
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
                                                                                          List<ProcedimentosRow> categoriaGProcedimentosRowList = snapshot.data!;

                                                                                          return Text(
                                                                                            valueOrDefault<String>(
                                                                                              categoriaGProcedimentosRowList.firstOrNull?.nome,
                                                                                              'Procedimento',
                                                                                            ),
                                                                                            textAlign: TextAlign.center,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.inter(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  fontSize: 12,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 270,
                                                                                    height: 50,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: FutureBuilder<List<ClientesRow>>(
                                                                                        future: ClientesTable().queryRows(
                                                                                          queryFn: (q) => q.eqOrNull(
                                                                                            'id',
                                                                                            listReceberContaReceberRow.idCliente,
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
                                                                                          List<ClientesRow> itemClientesRowList = snapshot.data!;

                                                                                          return Text(
                                                                                            valueOrDefault<String>(
                                                                                              itemClientesRowList.firstOrNull?.nome,
                                                                                              'Nome',
                                                                                            ),
                                                                                            textAlign: TextAlign.center,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.inter(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  fontSize: 12,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 220,
                                                                                    height: 30,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        formatNumber(
                                                                                          listReceberContaReceberRow.valorProcediemtno!,
                                                                                          formatType: FormatType.custom,
                                                                                          currency: 'R\$ ',
                                                                                          format: '#,##0.00',
                                                                                          locale: 'pt_BR',
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              fontSize: 12,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 100,
                                                                                    height: 50,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: FlutterFlowIconButton(
                                                                                        borderRadius: 20,
                                                                                        buttonSize: 40,
                                                                                        fillColor: FlutterFlowTheme.of(context).tertiary,
                                                                                        icon: Icon(
                                                                                          Icons.search,
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
                                                                                              return GestureDetector(
                                                                                                onTap: () {
                                                                                                  FocusScope.of(context).unfocus();
                                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                                },
                                                                                                child: Padding(
                                                                                                  padding: MediaQuery.viewInsetsOf(context),
                                                                                                  child: DescricaoRecebimentoWidget(
                                                                                                    idReceber: listReceberContaReceberRow.id,
                                                                                                    idProcedimento: listReceberContaReceberRow.idProcedimento!,
                                                                                                    idNome: listReceberContaReceberRow.idCliente!,
                                                                                                    valor: listReceberContaReceberRow.valorProcediemtno!,
                                                                                                    dataCompra: listReceberContaReceberRow.createdAt,
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                          ).then((value) => safeSetState(() {}));
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 60,
                                                                                    height: 50,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: FlutterFlowIconButton(
                                                                                        borderRadius: 20,
                                                                                        buttonSize: 40,
                                                                                        fillColor: FlutterFlowTheme.of(context).success,
                                                                                        icon: FaIcon(
                                                                                          FontAwesomeIcons.penNib,
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
                                                                                              return GestureDetector(
                                                                                                onTap: () {
                                                                                                  FocusScope.of(context).unfocus();
                                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                                },
                                                                                                child: Padding(
                                                                                                  padding: MediaQuery.viewInsetsOf(context),
                                                                                                  child: EditarRecebidoWidget(
                                                                                                    idCliente: listReceberContaReceberRow.idCliente!,
                                                                                                    quantSessoes: listReceberContaReceberRow.parcelas!,
                                                                                                    valorProcedimento: listReceberContaReceberRow.valorProcediemtno!,
                                                                                                    formaPagamento: listReceberContaReceberRow.formaPagamento!,
                                                                                                    parcelas: listReceberContaReceberRow.parcelas!,
                                                                                                    statusProcedimento: listReceberContaReceberRow.statusProcedimento!,
                                                                                                    statusFinanceiro: listReceberContaReceberRow.statusFinanceiro!,
                                                                                                    idPlano: listReceberContaReceberRow.idPlano!,
                                                                                                    idRecebido: listReceberContaReceberRow.id,
                                                                                                    procedimento: listReceberContaReceberRow.idProcedimento,
                                                                                                    dataVenci: listReceberContaReceberRow.dataVencimento!,
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                          ).then((value) => safeSetState(() {}));
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              if (FFAppState().gestaoMenu ==
                                                  'Estoque')
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  child: SingleChildScrollView(
                                                    primary: false,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    width: 300,
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
                                                                    width: 160,
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
                                                                    width: 160,
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
                                                                    width: 160,
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
                                                                        'Editar',
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
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      5, 0, 0),
                                                          child: Container(
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
                                                                          VwEstoqueAtualRow>>(
                                                                    future: VwEstoqueAtualTable()
                                                                        .queryRows(
                                                                      queryFn: (q) => q
                                                                          .eqOrNull(
                                                                            'id_companhia',
                                                                            gestaoUsuariosRow?.idCompanhia,
                                                                          )
                                                                          .eqOrNull(
                                                                            'id_produto',
                                                                            _model.filtroproduto,
                                                                          )
                                                                          .gtOrNull(
                                                                            'quantidade_atual',
                                                                            0,
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
                                                                      List<VwEstoqueAtualRow>
                                                                          listViewVwEstoqueAtualRowList =
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
                                                                            listViewVwEstoqueAtualRowList.length,
                                                                        separatorBuilder:
                                                                            (_, __) =>
                                                                                SizedBox(height: 10),
                                                                        itemBuilder:
                                                                            (context,
                                                                                listViewIndex) {
                                                                          final listViewVwEstoqueAtualRow =
                                                                              listViewVwEstoqueAtualRowList[listViewIndex];
                                                                          return Container(
                                                                            height:
                                                                                50,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                              child: FutureBuilder<List<ProdutosRow>>(
                                                                                future: ProdutosTable().querySingleRow(
                                                                                  queryFn: (q) => q
                                                                                      .eqOrNull(
                                                                                        'id_companhia',
                                                                                        gestaoUsuariosRow?.idCompanhia,
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'id',
                                                                                        listViewVwEstoqueAtualRow.idProduto,
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
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 300,
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
                                                                                        width: 160,
                                                                                        decoration: BoxDecoration(),
                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                        child: Text(
                                                                                          valueOrDefault<String>(
                                                                                            listViewVwEstoqueAtualRow.tipoEmbalagem,
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
                                                                                        width: 160,
                                                                                        decoration: BoxDecoration(),
                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                        child: Text(
                                                                                          valueOrDefault<String>(
                                                                                            listViewVwEstoqueAtualRow.quantidadeAtual.toString(),
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
                                                                                        future: EstoqueTable().queryRows(
                                                                                          queryFn: (q) => q
                                                                                              .eqOrNull(
                                                                                                'id_companhia',
                                                                                                gestaoUsuariosRow?.idCompanhia,
                                                                                              )
                                                                                              .eqOrNull(
                                                                                                'id_produto',
                                                                                                listViewVwEstoqueAtualRow.idProduto,
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

                                                                                          return Container(
                                                                                            width: 160,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0, 0),
                                                                                              child: FlutterFlowIconButton(
                                                                                                borderRadius: 20,
                                                                                                buttonSize: 40,
                                                                                                fillColor: FlutterFlowTheme.of(context).success,
                                                                                                icon: FaIcon(
                                                                                                  FontAwesomeIcons.penNib,
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
                                                                                                      return GestureDetector(
                                                                                                        onTap: () {
                                                                                                          FocusScope.of(context).unfocus();
                                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                                        },
                                                                                                        child: Padding(
                                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                                          child: AEditarEstoqueWidget(
                                                                                                            idEstoque: listViewVwEstoqueAtualRow.idProduto!,
                                                                                                            produtoId: listViewVwEstoqueAtualRow.idProduto!,
                                                                                                            tipoEmbalagem: linhaGeralProdutosRow!.tipoEmbalagem!,
                                                                                                            quantidade: listViewVwEstoqueAtualRow.quantidadeAtual!,
                                                                                                            nomeProduto: linhaGeralProdutosRow!.produtos!,
                                                                                                          ),
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
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
          ),
        );
      },
    );
  }
}
