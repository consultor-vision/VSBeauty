import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'historico_plano_widget.dart' show HistoricoPlanoWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HistoricoPlanoModel extends FlutterFlowModel<HistoricoPlanoWidget> {
  ///  Local state fields for this component.

  List<AgendamentoRow> lsSessoes = [];
  void addToLsSessoes(AgendamentoRow item) => lsSessoes.add(item);
  void removeFromLsSessoes(AgendamentoRow item) => lsSessoes.remove(item);
  void removeAtIndexFromLsSessoes(int index) => lsSessoes.removeAt(index);
  void insertAtIndexInLsSessoes(int index, AgendamentoRow item) =>
      lsSessoes.insert(index, item);
  void updateLsSessoesAtIndex(int index, Function(AgendamentoRow) updateFn) =>
      lsSessoes[index] = updateFn(lsSessoes[index]);

  int? quantSess;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in Historico_Plano widget.
  List<AgendamentoRow>? agendamento;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
