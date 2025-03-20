// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class ForgetPassword extends StatelessWidget {
  String title;
  ForgetPassword({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center the column content
        children: [
          const Center(
            child: Text(
              'التحقق من هويتك',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center, // Ensure it's centered
            ),
          ),
          verticalSpace(8),
          Align(
            alignment: Alignment.centerRight, // Align text to the right
            child: Text(
              title,
              style: TextStyles.semiBold16.copyWith(
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
