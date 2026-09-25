import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/anamnese/editar_ficha/c_m_p_editar_anamnese/c_m_p_editar_anamnese_widget.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'editar_ficha_anamnese_model.dart';
export 'editar_ficha_anamnese_model.dart';

class EditarFichaAnamneseWidget extends StatefulWidget {
  const EditarFichaAnamneseWidget({super.key});

  @override
  State<EditarFichaAnamneseWidget> createState() =>
      _EditarFichaAnamneseWidgetState();
}

class _EditarFichaAnamneseWidgetState extends State<EditarFichaAnamneseWidget> {
  late EditarFichaAnamneseModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditarFichaAnamneseModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.edicaoAS = await VwAnamneseCompletaTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'id_companhia',
              FFAppState().idCompanhia,
            )
            .eqOrNull(
              'id_cliente',
              FFAppState().idCliente,
            )
            .order('ordem', ascending: true),
      );
      _model.idsList = _model.edicaoAS!
          .map((e) => e.perguntaId)
          .withoutNulls
          .toList()
          .toList()
          .cast<int>();
      _model.respostasList = _model.edicaoAS!
          .map((e) => e.resposta)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      _model.complementosList = _model.edicaoAS!
          .map((e) => e.complemento)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      _model.perguntasList = _model.edicaoAS!
          .map((e) => e.pergunta)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      _model.ordem = _model.edicaoAS!
          .map((e) => e.ordem)
          .withoutNulls
          .toList()
          .toList()
          .cast<int>();
      _model.casoSim = _model.edicaoAS!
          .map((e) => e.casoSim)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
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
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0, 0),
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
          List<UsuariosRow> cTNAnamneseUsuariosRowList = snapshot.data!;

          final cTNAnamneseUsuariosRow = cTNAnamneseUsuariosRowList.isNotEmpty
              ? cTNAnamneseUsuariosRowList.first
              : null;

          return Material(
            color: Colors.transparent,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: 1400,
              height: 885,
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 12, 0, 8),
                        child: Text(
                          'Editar Ficha de Anamnese',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
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
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
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
                    width: 1484.7,
                    height: 742.63,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 825,
                            decoration: BoxDecoration(),
                            child: FutureBuilder<List<VwAnamneseCompletaRow>>(
                              future: VwAnamneseCompletaTable().queryRows(
                                queryFn: (q) => q
                                    .eqOrNull(
                                      'id_companhia',
                                      cTNAnamneseUsuariosRow?.idCompanhia,
                                    )
                                    .eqOrNull(
                                      'id_cliente',
                                      FFAppState().idCliente,
                                    )
                                    .order('ordem', ascending: true),
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
                                List<VwAnamneseCompletaRow>
                                    listViewVwAnamneseCompletaRowList =
                                    snapshot.data!;

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      listViewVwAnamneseCompletaRowList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewVwAnamneseCompletaRow =
                                        listViewVwAnamneseCompletaRowList[
                                            listViewIndex];
                                    return SingleChildScrollView(
                                      primary: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          CMPEditarAnamneseWidget(
                                            key: Key(
                                                'Key170_${listViewIndex}_of_${listViewVwAnamneseCompletaRowList.length}'),
                                            pergunta:
                                                listViewVwAnamneseCompletaRow
                                                    .pergunta,
                                            casoSim:
                                                listViewVwAnamneseCompletaRow
                                                    .casoSim!,
                                            indice:
                                                listViewVwAnamneseCompletaRow
                                                    .ordem!,
                                            complemento:
                                                listViewVwAnamneseCompletaRow
                                                    .complemento!,
                                            resposta:
                                                listViewVwAnamneseCompletaRow
                                                    .resposta!,
                                            perguntaid:
                                                listViewVwAnamneseCompletaRow
                                                    .perguntaId!,
                                            idcliente:
                                                listViewVwAnamneseCompletaRow
                                                    .idCliente!,
                                          ),
                                        ],
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
            ),
          );
        },
      ),
    );
  }
}
