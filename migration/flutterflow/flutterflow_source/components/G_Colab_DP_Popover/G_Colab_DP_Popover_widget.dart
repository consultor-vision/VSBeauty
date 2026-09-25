import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/g_geral/calendario_popover/calendar_popover/calendar_popover_widget.dart';
import 'dart:ui';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'g_colab_d_p_popover_model.dart';
export 'g_colab_d_p_popover_model.dart';

class GColabDPPopoverWidget extends StatefulWidget {
  const GColabDPPopoverWidget({super.key});

  @override
  State<GColabDPPopoverWidget> createState() => _GColabDPPopoverWidgetState();
}

class _GColabDPPopoverWidgetState extends State<GColabDPPopoverWidget> {
  late GColabDPPopoverModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GColabDPPopoverModel());

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
      child: Builder(
        builder: (context) => InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            await showAlignedDialog(
              barrierColor: Colors.transparent,
              context: context,
              isGlobal: false,
              avoidOverflow: false,
              targetAnchor: AlignmentDirectional(0, -1)
                  .resolve(Directionality.of(context)),
              followerAnchor: AlignmentDirectional(0, 1)
                  .resolve(Directionality.of(context)),
              builder: (dialogContext) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 300,
                    child: CalendarPopoverWidget(
                      initialDate: _model.selectedDate,
                      onSelect: (pickedDate) async {
                        _model.selectedDate = pickedDate;
                        safeSetState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            width: 280,
            height: 40,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryText,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: FlutterFlowTheme.of(context).tertiary,
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    valueOrDefault<String>(
                      dateTimeFormat(
                        "dd/MM/yyyy",
                        _model.selectedDate,
                        locale: FFLocalizations.of(context).languageCode,
                      ),
                      'Selecione a Data de Nascimento',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  Icon(
                    Icons.calendar_month,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
