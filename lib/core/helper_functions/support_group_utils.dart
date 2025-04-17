import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// يحول `TimeOfDay` إلى `DateTime` بالنسبة لتاريخ اليوم
DateTime convertToDateTime(TimeOfDay time) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, time.hour, time.minute);
}

/// يُرجع تاريخ الجلسة كنص بصيغة "yyyy-MM-dd"
String formatSupportGroupDate(TimeOfDay time) {
  final dateTime = convertToDateTime(time);
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

/// يُحسب مدة الجلسة (ساعة ونصف) ويُرجعها كنص بصيغة "ساعة ونصف" أو "X ساعة Y دقيقة"
String calculateSessionDuration(TimeOfDay time, {int minutesToAdd = 90}) {
  final startDateTime = convertToDateTime(time);
  final endDateTime = startDateTime.add(Duration(minutes: minutesToAdd));
  final duration = endDateTime.difference(startDateTime);

  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);

  if (hours > 0 && minutes > 0) {
    return "$hours ساعة و $minutes دقيقة";
  } else if (hours > 0) {
    return "$hours ساعة";
  } else {
    return "$minutes دقيقة";
  }
}
