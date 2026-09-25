import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/vision_smart_beauty/d_evolucao/componentes_evolucao/b_editar_evolucao_copy/b_editar_evolucao_copy_widget.dart';
import '/vision_smart_beauty/g_geral/menu/menu_central/menu_central_widget.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'evolucao_model.dart';
export 'evolucao_model.dart';

class EvolucaoWidget extends StatefulWidget {
  const EvolucaoWidget({
    super.key,
    this.idCliente,
    required this.idagendamento,
    required this.idplano,
  });

  final int? idCliente;
  final int? idagendamento;
  final int? idplano;

  static String routeName = 'Evolucao';
  static String routePath = '/Evolucao';

  @override
  State<EvolucaoWidget> createState() => _EvolucaoWidgetState();
}

class _EvolucaoWidgetState extends State<EvolucaoWidget> {
  late EvolucaoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EvolucaoModel());

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
        List<UsuariosRow> evolucaoUsuariosRowList = snapshot.data!;

        final evolucaoUsuariosRow = evolucaoUsuariosRowList.isNotEmpty
            ? evolucaoUsuariosRowList.first
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
                child: FutureBuilder<List<ClientesRow>>(
                  future: ClientesTable().querySingleRow(
                    queryFn: (q) => q
                        .eqOrNull(
                          'id_companhia',
                          evolucaoUsuariosRow?.idCompanhia,
                        )
                        .eqOrNull(
                          'id',
                          widget!.idCliente,
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
                    List<ClientesRow> evolucaoClienteClientesRowList =
                        snapshot.data!;

                    final evolucaoClienteClientesRow =
                        evolucaoClienteClientesRowList.isNotEmpty
                            ? evolucaoClienteClientesRowList.first
                            : null;

                    return Container(
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(0, 0),
                      child: FutureBuilder<List<CompanhiaRow>>(
                        future: CompanhiaTable().querySingleRow(
                          queryFn: (q) => q.eqOrNull(
                            'id',
                            evolucaoUsuariosRow?.idCompanhia,
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
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25, 10, 10, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(1, 0, 0, 0),
                                                child: Text(
                                                  'Evolução do Cliente',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        fontSize: 22,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                        Divider(
                                          thickness: 2,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                        ),
                                        FutureBuilder<List<PlanosRow>>(
                                          future: PlanosTable().querySingleRow(
                                            queryFn: (q) => q
                                                .eqOrNull(
                                                  'id_companhia',
                                                  evolucaoUsuariosRow
                                                      ?.idCompanhia,
                                                )
                                                .eqOrNull(
                                                  'id_cliente',
                                                  widget!.idCliente,
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
                                            List<PlanosRow>
                                                telaGeralPlanosRowList =
                                                snapshot.data!;

                                            final telaGeralPlanosRow =
                                                telaGeralPlanosRowList
                                                        .isNotEmpty
                                                    ? telaGeralPlanosRowList
                                                        .first
                                                    : null;

                                            return Container(
                                              width: double.infinity,
                                              height: 762,
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  FutureBuilder<
                                                      List<AgendamentoRow>>(
                                                    future: AgendamentoTable()
                                                        .queryRows(
                                                      queryFn: (q) =>
                                                          q.eqOrNull(
                                                        'id_cliente',
                                                        widget!.idCliente,
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
                                                          cTNPadraoAgendamentoRowList =
                                                          snapshot.data!;

                                                      return Container(
                                                        width: 700,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                1.012,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: FutureBuilder<
                                                            List<
                                                                EvolucaoClienteRow>>(
                                                          future:
                                                              EvolucaoClienteTable()
                                                                  .querySingleRow(
                                                            queryFn: (q) => q,
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
                                                                cTNDadosEvolucaoClienteRowList =
                                                                snapshot.data!;

                                                            final cTNDadosEvolucaoClienteRow =
                                                                cTNDadosEvolucaoClienteRowList
                                                                        .isNotEmpty
                                                                    ? cTNDadosEvolucaoClienteRowList
                                                                        .first
                                                                    : null;

                                                            return Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          1200.3,
                                                                      height:
                                                                          40,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            15,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
                                                                            Container(
                                                                              decoration: BoxDecoration(),
                                                                              alignment: AlignmentDirectional(0, 0),
                                                                              child: RichText(
                                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: 'Nome: ',
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
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: valueOrDefault<String>(
                                                                                        evolucaoClienteClientesRow?.nome,
                                                                                        'Cliente',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: ' | Data de Nascimento: ',
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
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: valueOrDefault<String>(
                                                                                        dateTimeFormat(
                                                                                          "d/M/y",
                                                                                          evolucaoClienteClientesRow?.dataNascimento,
                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                        ),
                                                                                        'Sem Data de Nascimento',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: ' |  CPF: ',
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
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: valueOrDefault<String>(
                                                                                        evolucaoClienteClientesRow?.cpf,
                                                                                        'CPF',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).tertiary,
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
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        fontSize: 16,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 5)).around(SizedBox(height: 5)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  FutureBuilder<
                                                                      List<
                                                                          PlanosRow>>(
                                                                    future: PlanosTable()
                                                                        .queryRows(
                                                                      queryFn: (q) => q
                                                                          .eqOrNull(
                                                                            'id_companhia',
                                                                            evolucaoUsuariosRow?.idCompanhia,
                                                                          )
                                                                          .eqOrNull(
                                                                            'id_cliente',
                                                                            widget!.idCliente,
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
                                                                      List<PlanosRow>
                                                                          cTNDropDownPlanosRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return Container(
                                                                        height:
                                                                            40,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 2, 0),
                                                                              child: FlutterFlowDropDown<String>(
                                                                                controller: _model.dropDownProcediemtnoValueController ??= FormFieldController<String>(
                                                                                  _model.dropDownProcediemtnoValue ??= 'Procedimentos',
                                                                                ),
                                                                                options: cTNDropDownPlanosRowList
                                                                                    .map((e) => valueOrDefault<String>(
                                                                                          e.nomePlano,
                                                                                          'Nome',
                                                                                        ))
                                                                                    .toList(),
                                                                                onChanged: (val) async {
                                                                                  safeSetState(() => _model.dropDownProcediemtnoValue = val);
                                                                                  _model.outPlano1 = await PlanosTable().queryRows(
                                                                                    queryFn: (q) => q
                                                                                        .eqOrNull(
                                                                                          'id_cliente',
                                                                                          widget!.idCliente,
                                                                                        )
                                                                                        .eqOrNull(
                                                                                          'nome_plano',
                                                                                          _model.dropDownProcediemtnoValue,
                                                                                        ),
                                                                                  );
                                                                                  _model.outProfissional = await UsuariosTable().queryRows(
                                                                                    queryFn: (q) => q.eqOrNull(
                                                                                      'id_companhia',
                                                                                      evolucaoUsuariosRow?.idCompanhia,
                                                                                    ),
                                                                                  );
                                                                                  _model.outPlanoContagem = await AgendamentoTable().queryRows(
                                                                                    queryFn: (q) => q
                                                                                        .eqOrNull(
                                                                                          'id_companhia',
                                                                                          evolucaoUsuariosRow?.idCompanhia,
                                                                                        )
                                                                                        .eqOrNull(
                                                                                          'id_cliente',
                                                                                          widget!.idCliente,
                                                                                        )
                                                                                        .eqOrNull(
                                                                                          'id_plano',
                                                                                          _model.outPlano1?.firstOrNull?.id,
                                                                                        ),
                                                                                  );

                                                                                  safeSetState(() {});
                                                                                },
                                                                                width: 622.5,
                                                                                height: 40,
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
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                hintText: 'Selecione Procedimento',
                                                                                searchHintText: 'Pesquisar',
                                                                                searchCursorColor: FlutterFlowTheme.of(context).tertiary,
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
                                                                              ),
                                                                            ),
                                                                            FFButtonWidget(
                                                                              onPressed: () async {
                                                                                safeSetState(() {
                                                                                  _model.dropDownProcediemtnoValueController?.reset();
                                                                                  _model.dropDownProcediemtnoValue = null;
                                                                                });
                                                                                _model.idAgendamento = null;
                                                                                safeSetState(() {});
                                                                              },
                                                                              text: '',
                                                                              icon: Icon(
                                                                                Icons.restore_from_trash,
                                                                                size: 25,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                width: 30,
                                                                                height: double.infinity,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      font: GoogleFonts.interTight(
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                      color: Colors.white,
                                                                                      fontSize: 12,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                elevation: 10,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          210,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
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
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 80,
                                                                                          height: 40,
                                                                                          decoration: BoxDecoration(),
                                                                                          alignment: AlignmentDirectional(0, 0),
                                                                                          child: Text(
                                                                                            'Data de Execução',
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
                                                                                          width: 250,
                                                                                          height: 40,
                                                                                          decoration: BoxDecoration(),
                                                                                          alignment: AlignmentDirectional(0, 0),
                                                                                          child: Text(
                                                                                            'Plano',
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
                                                                                          width: 182,
                                                                                          height: 40,
                                                                                          decoration: BoxDecoration(),
                                                                                          alignment: AlignmentDirectional(0, 0),
                                                                                          child: Text(
                                                                                            'Profissional',
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
                                                                                          width: 70,
                                                                                          height: 40,
                                                                                          decoration: BoxDecoration(),
                                                                                          alignment: AlignmentDirectional(0, 0),
                                                                                          child: Text(
                                                                                            'Editar a Sessão',
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
                                                                                          width: 70,
                                                                                          height: 40,
                                                                                          decoration: BoxDecoration(),
                                                                                          alignment: AlignmentDirectional(0, 0),
                                                                                          child: Text(
                                                                                            'Acessar a Sessão',
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
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                164.7,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Visibility(
                                                                              visible: _model.dropDownProcediemtnoValue != null && _model.dropDownProcediemtnoValue != '',
                                                                              child: FutureBuilder<List<AgendamentoRow>>(
                                                                                future: AgendamentoTable().queryRows(
                                                                                  queryFn: (q) => q
                                                                                      .eqOrNull(
                                                                                        'id_cliente',
                                                                                        widget!.idCliente,
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'status_procedimento',
                                                                                        'Concluído',
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'id_plano',
                                                                                        _model.outPlano1?.firstOrNull?.id,
                                                                                      )
                                                                                      .order('data_inicio'),
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
                                                                                  List<AgendamentoRow> listViewAgendamentoRowList = snapshot.data!;

                                                                                  return ListView.builder(
                                                                                    padding: EdgeInsets.zero,
                                                                                    scrollDirection: Axis.vertical,
                                                                                    itemCount: listViewAgendamentoRowList.length,
                                                                                    itemBuilder: (context, listViewIndex) {
                                                                                      final listViewAgendamentoRow = listViewAgendamentoRowList[listViewIndex];
                                                                                      return Align(
                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(5, 2.5, 5, 2.5),
                                                                                          child: Container(
                                                                                            height: 45,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(8),
                                                                                              border: Border.all(
                                                                                                color: _model.idAgendamento.toString() == listViewAgendamentoRow.id.toString() ? FlutterFlowTheme.of(context).secondary : Color(0x00000000),
                                                                                              ),
                                                                                            ),
                                                                                            alignment: AlignmentDirectional(0, 0),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 522.7,
                                                                                                  height: 45,
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        width: 80,
                                                                                                        height: 45,
                                                                                                        decoration: BoxDecoration(),
                                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<String>(
                                                                                                            dateTimeFormat(
                                                                                                              "d/M/y",
                                                                                                              listViewAgendamentoRow.dataInicio,
                                                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                                                            ),
                                                                                                            'Data',
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
                                                                                                      Container(
                                                                                                        width: 250,
                                                                                                        height: 45,
                                                                                                        decoration: BoxDecoration(),
                                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                                        child: FutureBuilder<List<PlanosRow>>(
                                                                                                          future: PlanosTable().querySingleRow(
                                                                                                            queryFn: (q) => q
                                                                                                                .eqOrNull(
                                                                                                                  'id_companhia',
                                                                                                                  evolucaoUsuariosRow?.idCompanhia,
                                                                                                                )
                                                                                                                .eqOrNull(
                                                                                                                  'id',
                                                                                                                  listViewAgendamentoRow.idPlano,
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
                                                                                                            List<PlanosRow> planoPlanosRowList = snapshot.data!;

                                                                                                            final planoPlanosRow = planoPlanosRowList.isNotEmpty ? planoPlanosRowList.first : null;

                                                                                                            return Text(
                                                                                                              valueOrDefault<String>(
                                                                                                                planoPlanosRow?.nomePlano,
                                                                                                                'Plano',
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
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                      ),
                                                                                                      Container(
                                                                                                        width: 182,
                                                                                                        height: 45,
                                                                                                        decoration: BoxDecoration(),
                                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                                        child: FutureBuilder<List<UsuariosRow>>(
                                                                                                          future: UsuariosTable().querySingleRow(
                                                                                                            queryFn: (q) => q
                                                                                                                .eqOrNull(
                                                                                                                  'id_companhia',
                                                                                                                  evolucaoUsuariosRow?.idCompanhia,
                                                                                                                )
                                                                                                                .eqOrNull(
                                                                                                                  'id',
                                                                                                                  listViewAgendamentoRow.idProfissional,
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
                                                                                                            List<UsuariosRow> profissionalUsuariosRowList = snapshot.data!;

                                                                                                            final profissionalUsuariosRow = profissionalUsuariosRowList.isNotEmpty ? profissionalUsuariosRowList.first : null;

                                                                                                            return Text(
                                                                                                              valueOrDefault<String>(
                                                                                                                profissionalUsuariosRow?.nome,
                                                                                                                'Profissional',
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
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                FutureBuilder<List<ProcedimentosRow>>(
                                                                                                  future: ProcedimentosTable().querySingleRow(
                                                                                                    queryFn: (q) => q.eqOrNull(
                                                                                                      'id_companhia',
                                                                                                      evolucaoUsuariosRow?.idCompanhia,
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
                                                                                                    List<ProcedimentosRow> ctnEditarProcedimentosRowList = snapshot.data!;

                                                                                                    final ctnEditarProcedimentosRow = ctnEditarProcedimentosRowList.isNotEmpty ? ctnEditarProcedimentosRowList.first : null;

                                                                                                    return Container(
                                                                                                      width: 70,
                                                                                                      height: 45,
                                                                                                      decoration: BoxDecoration(),
                                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                                      child: InkWell(
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
                                                                                                              return GestureDetector(
                                                                                                                onTap: () {
                                                                                                                  FocusScope.of(context).unfocus();
                                                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                },
                                                                                                                child: Padding(
                                                                                                                  padding: MediaQuery.viewInsetsOf(context),
                                                                                                                  child: BEditarEvolucaoCopyWidget(
                                                                                                                    dataagendamento: listViewAgendamentoRow.dataInicio!,
                                                                                                                    horarioagendamento: listViewAgendamentoRow.horaInicio!.time,
                                                                                                                    idclienteagendamento: listViewAgendamentoRow.idCliente!,
                                                                                                                    idagendamento: listViewAgendamentoRow.id,
                                                                                                                    idPlanmoAgendamento: listViewAgendamentoRow.idPlano!,
                                                                                                                    nomePlano: telaGeralPlanosRow!.nomePlano!,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          ).then((value) => safeSetState(() {}));
                                                                                                        },
                                                                                                        child: Icon(
                                                                                                          Icons.edit_off,
                                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                          size: 30,
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                                FutureBuilder<List<PlanosRow>>(
                                                                                                  future: PlanosTable().querySingleRow(
                                                                                                    queryFn: (q) => q
                                                                                                        .eqOrNull(
                                                                                                          'id_companhia',
                                                                                                          evolucaoUsuariosRow?.idCompanhia,
                                                                                                        )
                                                                                                        .eqOrNull(
                                                                                                          'id',
                                                                                                          listViewAgendamentoRow.idPlano,
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
                                                                                                    List<PlanosRow> ctnAcessarPlanosRowList = snapshot.data!;

                                                                                                    final ctnAcessarPlanosRow = ctnAcessarPlanosRowList.isNotEmpty ? ctnAcessarPlanosRowList.first : null;

                                                                                                    return Container(
                                                                                                      width: 70,
                                                                                                      height: 45,
                                                                                                      decoration: BoxDecoration(),
                                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                                      child: FutureBuilder<List<ProcedimentosRow>>(
                                                                                                        future: ProcedimentosTable().querySingleRow(
                                                                                                          queryFn: (q) => q.eqOrNull(
                                                                                                            'id_companhia',
                                                                                                            evolucaoUsuariosRow?.idCompanhia,
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
                                                                                                          List<ProcedimentosRow> rowProcedimentosRowList = snapshot.data!;

                                                                                                          final rowProcedimentosRow = rowProcedimentosRowList.isNotEmpty ? rowProcedimentosRowList.first : null;

                                                                                                          return Row(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [
                                                                                                              InkWell(
                                                                                                                splashColor: Colors.transparent,
                                                                                                                focusColor: Colors.transparent,
                                                                                                                hoverColor: Colors.transparent,
                                                                                                                highlightColor: Colors.transparent,
                                                                                                                onTap: () async {
                                                                                                                  _model.idplano = telaGeralPlanosRow?.id;
                                                                                                                  safeSetState(() {});
                                                                                                                  _model.idAgendamento = listViewAgendamentoRow.id;
                                                                                                                  safeSetState(() {});
                                                                                                                  _model.cor = 'SIM';
                                                                                                                  safeSetState(() {});
                                                                                                                },
                                                                                                                child: Icon(
                                                                                                                  Icons.send,
                                                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                                                  size: 30,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          );
                                                                                                        },
                                                                                                      ),
                                                                                                    );
                                                                                                  },
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
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: FutureBuilder<
                                                                        List<
                                                                            EvolucaoClienteRow>>(
                                                                      future: EvolucaoClienteTable()
                                                                          .querySingleRow(
                                                                        queryFn:
                                                                            (q) =>
                                                                                q.eqOrNull(
                                                                          'id_agendamento',
                                                                          _model
                                                                              .idAgendamento,
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
                                                                              width: 50,
                                                                              height: 50,
                                                                              child: SpinKitFadingFour(
                                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                                size: 50,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        List<EvolucaoClienteRow>
                                                                            cTNObservacoesEvolucaoClienteRowList =
                                                                            snapshot.data!;

                                                                        final cTNObservacoesEvolucaoClienteRow = cTNObservacoesEvolucaoClienteRowList.isNotEmpty
                                                                            ? cTNObservacoesEvolucaoClienteRowList.first
                                                                            : null;

                                                                        return Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              210,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            border:
                                                                                Border.all(
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(1, 5, 0, 0),
                                                                                child: Text(
                                                                                  'Observação',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: Color(0x80F9CF58),
                                                                                        fontSize: 18,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                                                                child: Container(
                                                                                  width: 665,
                                                                                  height: 124.77,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Visibility(
                                                                                    visible: _model.idAgendamento != null,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                                                      child: Text(
                                                                                        valueOrDefault<String>(
                                                                                          cTNObservacoesEvolucaoClienteRow?.observacao,
                                                                                          'Observação',
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
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: FutureBuilder<
                                                                        List<
                                                                            VwEstoqueEvolucaoRow>>(
                                                                      future: VwEstoqueEvolucaoTable()
                                                                          .queryRows(
                                                                        queryFn:
                                                                            (q) =>
                                                                                q.eqOrNull(
                                                                          'id_agendamento',
                                                                          _model
                                                                              .idAgendamento,
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
                                                                            cTNProdutosVwEstoqueEvolucaoRowList =
                                                                            snapshot.data!;

                                                                        return Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              210,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            border:
                                                                                Border.all(
                                                                              color: FlutterFlowTheme.of(context).tertiary,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0, -1),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Container(
                                                                                  height: 30,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 200,
                                                                                        height: 50,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(0, 0),
                                                                                          child: Text(
                                                                                            'Produtos',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(0, 0),
                                                                                          child: Text(
                                                                                            'Sistema de Medidas',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(0, 0),
                                                                                          child: Text(
                                                                                            'Quantidade',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                                                  height: 173.47,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: SingleChildScrollView(
                                                                                    primary: false,
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        Container(
                                                                                          height: 179.41,
                                                                                          decoration: BoxDecoration(),
                                                                                          alignment: AlignmentDirectional(0, -1),
                                                                                          child: Visibility(
                                                                                            visible: _model.idAgendamento != null,
                                                                                            child: FutureBuilder<List<VwEstoqueEvolucaoRow>>(
                                                                                              future: VwEstoqueEvolucaoTable().queryRows(
                                                                                                queryFn: (q) => q
                                                                                                    .eqOrNull(
                                                                                                      'id_companhia',
                                                                                                      evolucaoUsuariosRow?.idCompanhia,
                                                                                                    )
                                                                                                    .eqOrNull(
                                                                                                      'id_agendamento',
                                                                                                      _model.idAgendamento,
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
                                                                                                List<VwEstoqueEvolucaoRow> listViewVwEstoqueEvolucaoRowList = snapshot.data!;

                                                                                                return ListView.builder(
                                                                                                  padding: EdgeInsets.zero,
                                                                                                  primary: false,
                                                                                                  scrollDirection: Axis.vertical,
                                                                                                  itemCount: listViewVwEstoqueEvolucaoRowList.length,
                                                                                                  itemBuilder: (context, listViewIndex) {
                                                                                                    final listViewVwEstoqueEvolucaoRow = listViewVwEstoqueEvolucaoRowList[listViewIndex];
                                                                                                    return Container(
                                                                                                      height: 40,
                                                                                                      decoration: BoxDecoration(),
                                                                                                      child: Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
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
                                                                                                              List<ProdutosRow> cTNItemProdutosRowList = snapshot.data!;

                                                                                                              final cTNItemProdutosRow = cTNItemProdutosRowList.isNotEmpty ? cTNItemProdutosRowList.first : null;

                                                                                                              return Container(
                                                                                                                width: 200,
                                                                                                                decoration: BoxDecoration(),
                                                                                                                alignment: AlignmentDirectional(0, 0),
                                                                                                                child: Text(
                                                                                                                  valueOrDefault<String>(
                                                                                                                    cTNItemProdutosRow?.produtos,
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
                                                                                                              );
                                                                                                            },
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
                                                                                                        ],
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                );
                                                                                              },
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
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        height:
                                                                            5)),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  if (_model.idAgendamento !=
                                                      null)
                                                    FutureBuilder<
                                                        List<
                                                            EvolucaoClienteRow>>(
                                                      future:
                                                          EvolucaoClienteTable()
                                                              .querySingleRow(
                                                        queryFn: (q) =>
                                                            q.eqOrNull(
                                                          'id_agendamento',
                                                          _model.idAgendamento,
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
                                                            cTNImagemEvolucaoClienteRowList =
                                                            snapshot.data!;

                                                        final cTNImagemEvolucaoClienteRow =
                                                            cTNImagemEvolucaoClienteRowList
                                                                    .isNotEmpty
                                                                ? cTNImagemEvolucaoClienteRowList
                                                                    .first
                                                                : null;

                                                        return Container(
                                                          width: 683.94,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                      context)
                                                                  .height,
                                                          decoration:
                                                              BoxDecoration(
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
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: FutureBuilder<
                                                                    List<
                                                                        PlanosRow>>(
                                                                  future: PlanosTable()
                                                                      .querySingleRow(
                                                                    queryFn: (q) =>
                                                                        q.eqOrNull(
                                                                      'id',
                                                                      _model.outPlano1?.firstOrNull?.id !=
                                                                              null
                                                                          ? _model
                                                                              .outPlano1
                                                                              ?.firstOrNull
                                                                              ?.id
                                                                          : cTNImagemEvolucaoClienteRow
                                                                              ?.idAgendamento,
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
                                                                    List<PlanosRow>
                                                                        rowPlanosRowList =
                                                                        snapshot
                                                                            .data!;

                                                                    final rowPlanosRow = rowPlanosRowList
                                                                            .isNotEmpty
                                                                        ? rowPlanosRowList
                                                                            .first
                                                                        : null;

                                                                    return Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        FutureBuilder<
                                                                            List<AgendamentoRow>>(
                                                                          future:
                                                                              AgendamentoTable().querySingleRow(
                                                                            queryFn: (q) =>
                                                                                q.eqOrNull(
                                                                              'id',
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
                                                                                  child: SpinKitFadingFour(
                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                    size: 50,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            List<AgendamentoRow>
                                                                                tituloAgendamentoRowList =
                                                                                snapshot.data!;

                                                                            final tituloAgendamentoRow = tituloAgendamentoRowList.isNotEmpty
                                                                                ? tituloAgendamentoRowList.first
                                                                                : null;

                                                                            return Text(
                                                                              valueOrDefault<String>(
                                                                                rowPlanosRow?.nomePlano,
                                                                                'Nome',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: Color(0x80F9CF58),
                                                                                    fontSize: 18,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  if (_model
                                                                          .antesDepois ==
                                                                      true)
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              1,
                                                                              5,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        'Antes',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
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
                                                                  if (_model
                                                                          .antesDepois ==
                                                                      false)
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              1,
                                                                              5,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        'Depois',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                              if (_model
                                                                      .idAgendamento !=
                                                                  null)
                                                                Container(
                                                                  width: 500,
                                                                  height: 500,
                                                                  child: Stack(
                                                                    children: [
                                                                      if (_model
                                                                              .antesDepois ==
                                                                          true)
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            child:
                                                                                Image.network(
                                                                              valueOrDefault<String>(
                                                                                cTNImagemEvolucaoClienteRow?.antes,
                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vision-smart-beauty-l7vxwr/assets/07xf7era71f4/perfil_ok_ok.png',
                                                                              ),
                                                                              width: 500,
                                                                              height: 500,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      if (_model
                                                                              .antesDepois ==
                                                                          false)
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            child:
                                                                                Image.network(
                                                                              valueOrDefault<String>(
                                                                                cTNImagemEvolucaoClienteRow?.depois,
                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vision-smart-beauty-l7vxwr/assets/07xf7era71f4/perfil_ok_ok.png',
                                                                              ),
                                                                              width: 500,
                                                                              height: 500,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
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
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        _model.antesDepois =
                                                                            true;
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      text:
                                                                          'Antes',
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
                                                                        color: Color(
                                                                            0xA8F9CF58),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
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
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        _model.antesDepois =
                                                                            false;
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      text:
                                                                          'Depois',
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
                                                                        color: Color(
                                                                            0xA8F9CF58),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
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
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 6)),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                ],
                                              ),
                                            );
                                          },
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
                          );
                        },
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
