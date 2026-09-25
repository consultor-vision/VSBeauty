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

double calcTotalPlano(
  int? qtd,
  double? valor,
  double? entrada,
) {
  final int quantidade = qtd ?? 0;
  final double preco = valor ?? 0.0;
  final double valorEntrada = entrada ?? 0.0;

  if (quantidade <= 0 || preco <= 0) {
    return 0.0;
  }

  final double subtotal = quantidade * preco;
  final double totalFinal = subtotal - valorEntrada;

  // Evita valor negativo caso a entrada seja maior que o total
  return totalFinal < 0 ? 0.0 : totalFinal;
}
