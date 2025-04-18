import 'package:flutter/material.dart' show ListTile;
import 'package:flutter/widgets.dart';

import '../../../../../core/utils/app_colors.dart';

Widget buildInfoTile(IconData icon, String title, String value) {
  return ListTile(
    leading: Icon(icon, color: AppColors.primaryColor),
    title: Text(title, textAlign: TextAlign.right), // لجعل النص يبدأ من اليمين
    subtitle:
        Text(value, textAlign: TextAlign.right), // لجعل النص يبدأ من اليمين
  );
}
