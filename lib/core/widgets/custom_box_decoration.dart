import 'package:flutter/material.dart';

BoxDecoration customBoxDecoration({double? opacity, Color? mainColor}) {
  return BoxDecoration(
    color: mainColor ?? Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(opacity ?? 0.2),
        blurRadius: 12,
        offset: const Offset(0, 5),
      ),
    ],
  );
}
