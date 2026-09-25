import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/vision_smart_beauty/c_cadastro/componentes_cadastro/anamnese/nova_ficha/c_m_p_nova_anamnese_copy/c_m_p_nova_anamnese_copy_widget.dart';
import 'dart:convert';
import 'dart:ui';
import 'nova_ficha_anamnese_copy_widget.dart' show NovaFichaAnamneseCopyWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NovaFichaAnamneseCopyModel
    extends FlutterFlowModel<NovaFichaAnamneseCopyWidget> {
  ///  Local state fields for this component.

  List<String> perguntasList = [];
  void addToPerguntasList(String item) => perguntasList.add(item);
  void removeFromPerguntasList(String item) => perguntasList.remove(item);
  void removeAtIndexFromPerguntasList(int index) =>
      perguntasList.removeAt(index);
  void insertAtIndexInPerguntasList(int index, String item) =>
      perguntasList.insert(index, item);
  void updatePerguntasListAtIndex(int index, Function(String) updateFn) =>
      perguntasList[index] = updateFn(perguntasList[index]);

  List<String> respostasList = [];
  void addToRespostasList(String item) => respostasList.add(item);
  void removeFromRespostasList(String item) => respostasList.remove(item);
  void removeAtIndexFromRespostasList(int index) =>
      respostasList.removeAt(index);
  void insertAtIndexInRespostasList(int index, String item) =>
      respostasList.insert(index, item);
  void updateRespostasListAtIndex(int index, Function(String) updateFn) =>
      respostasList[index] = updateFn(respostasList[index]);

  List<String> complementosList = [];
  void addToComplementosList(String item) => complementosList.add(item);
  void removeFromComplementosList(String item) => complementosList.remove(item);
  void removeAtIndexFromComplementosList(int index) =>
      complementosList.removeAt(index);
  void insertAtIndexInComplementosList(int index, String item) =>
      complementosList.insert(index, item);
  void updateComplementosListAtIndex(int index, Function(String) updateFn) =>
      complementosList[index] = updateFn(complementosList[index]);

  int? idsList;

  int? idCliente;

  int? idCompanhia;

  List<String> casoSim = [];
  void addToCasoSim(String item) => casoSim.add(item);
  void removeFromCasoSim(String item) => casoSim.remove(item);
  void removeAtIndexFromCasoSim(int index) => casoSim.removeAt(index);
  void insertAtIndexInCasoSim(int index, String item) =>
      casoSim.insert(index, item);
  void updateCasoSimAtIndex(int index, Function(String) updateFn) =>
      casoSim[index] = updateFn(casoSim[index]);

  List<int> ordem = [];
  void addToOrdem(int item) => ordem.add(item);
  void removeFromOrdem(int item) => ordem.remove(item);
  void removeAtIndexFromOrdem(int index) => ordem.removeAt(index);
  void insertAtIndexInOrdem(int index, int item) => ordem.insert(index, item);
  void updateOrdemAtIndex(int index, Function(int) updateFn) =>
      ordem[index] = updateFn(ordem[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in Nova_Ficha_AnamneseCopy widget.
  List<AnamneseRow>? nova;
  // Stores action output result for [Backend Call - API (SalvarAnamneseCliente)] action in Linha_Salvar widget.
  ApiCallResponse? apiResulte5;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
