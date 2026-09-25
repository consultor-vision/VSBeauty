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

DateTime converterHoraParaDateTime(String hora) {
  if (hora.isEmpty) {
    return DateTime.now();
  }

  final partes = hora.split(':');

  final h = int.parse(partes[0]);
  final m = int.parse(partes[1]);

  final agora = DateTime.now();

  return DateTime(
    agora.year,
    agora.month,
    agora.day,
    h,
    m,
  );
}
