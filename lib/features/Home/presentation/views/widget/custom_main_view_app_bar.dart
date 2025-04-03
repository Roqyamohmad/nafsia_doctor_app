import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;

class CustomMainViewsAppBar extends StatelessWidget {
  final String title;
  const CustomMainViewsAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyles.bold23.copyWith(color: AppColors.primaryColor),
      ),
    );
  }
}
