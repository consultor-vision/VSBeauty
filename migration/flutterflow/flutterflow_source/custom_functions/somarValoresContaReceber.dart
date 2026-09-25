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

String somarValoresContaReceber(List<dynamic> lista) {
  double total = 0.0;

  for (var item in lista) {
    final valor = item['valor_procediemtno'];
    if (valor != null) {
      total += (valor as num).toDouble();
    }
  }

  // FormataÃ§Ã£o BR
  return 'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}';
}
