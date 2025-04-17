import 'package:flutter/material.dart';

Future<void> pickTime({
  required BuildContext context,
  required TimeOfDay selectedTime,
  required Function(TimeOfDay) onTimeSelected,
}) async {
  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime,
  );

  if (picked != null) {
    onTimeSelected(picked); // رجعي الوقت الجديد
  }
}
