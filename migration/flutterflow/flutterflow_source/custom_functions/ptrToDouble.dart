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

double ptbrToDouble(String? texto) {
  if (texto == null) return 0.0;
  String s = texto.trim();
  if (s.isEmpty) return 0.0;

  // mantÃ©m apenas dÃ­gitos, vÃ­rgula, ponto e sinais
  s = s.replaceAll(RegExp(r'[^0-9,.\-+]'), '');

  // decide qual Ã© o separador decimal
  final lastComma = s.lastIndexOf(',');
  final lastDot = s.lastIndexOf('.');

  if (lastComma > lastDot) {
    // decimal Ã© vÃ­rgula â remove pontos (milhar) e troca vÃ­rgula por ponto
    s = s.replaceAll('.', '');
    s = s.replaceAll(',', '.');
  } else if (lastDot > lastComma) {
    // decimal Ã© ponto â remove vÃ­rgulas (milhar)
    s = s.replaceAll(',', '');
  } else {
    // sÃ³ tem um ou nenhum â assume vÃ­rgula como decimal
    s = s.replaceAll(',', '.');
  }

  return double.tryParse(s) ?? 0.0;
}
