import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

DateTime? converterTextoParaData(String? dataTexto) {
  if (dataTexto == null || dataTexto.trim().isEmpty) {
    return null;
  }

  try {
    final partes = dataTexto.split('/');

    if (partes.length != 3) return null;

    final dia = int.parse(partes[0]);
    final mes = int.parse(partes[1]);
    final ano = int.parse(partes[2]);

    // ValidaÃ§Ã£o simples
    if (dia < 1 || dia > 31) return null;
    if (mes < 1 || mes > 12) return null;
    if (ano < 1900 || ano > 2100) return null;

    final data = DateTime(ano, mes, dia);

    // ValidaÃ§Ã£o extra para evitar datas invÃ¡lidas tipo 31/02/2020
    if (data.day != dia || data.month != mes || data.year != ano) {
      return null;
    }

    return data;
  } catch (e) {
    return null;
  }
}
