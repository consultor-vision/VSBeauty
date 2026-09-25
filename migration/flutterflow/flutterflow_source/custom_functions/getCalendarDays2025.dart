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

List<DateTime>? getCalendarDays2025(DateTime? date) {
  if (date == null) return [];

  final firstDay = DateTime(date.year, date.month, 1);
  final lastDay = DateTime(date.year, date.month + 1, 0);

  final weekdayIndex = firstDay.weekday % 7;
  final blankDays = List<DateTime>.filled(weekdayIndex, DateTime(1900, 1, 1));

  final daysInMonth = List<DateTime>.generate(
    lastDay.day,
    (i) => DateTime(date.year, date.month, i + 1),
  );

  return [...blankDays, ...daysInMonth];
}
