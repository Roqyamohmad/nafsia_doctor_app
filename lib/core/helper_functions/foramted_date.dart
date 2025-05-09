import 'package:cloud_firestore/cloud_firestore.dart';

String formatDateFromTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();

  return '$day/$month/$year';
}

String formatDateFromDateTime(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();

  return '$day/$month/$year';
}
