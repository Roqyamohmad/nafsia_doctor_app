import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

void pickSeats({
  required BuildContext context,
  required int selectedSeats,
  required Function(int) onSeatsSelected,
}) {
  showMaterialNumberPicker(
    context: context,
    title: "اختر عدد المقاعد",
    maxNumber: 10,
    minNumber: 1,
    selectedNumber: selectedSeats,
    onChanged: onSeatsSelected,
  );
}
