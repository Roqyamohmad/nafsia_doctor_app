import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';

class CustomUserInformationItem extends StatelessWidget {
  final String title, value;
  const CustomUserInformationItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Text(title, style: TextStyles.bold16),
          Expanded(
            child: Text(
              value,
              style: TextStyles.regular16,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
