import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart' show AppColors;
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_rounded,
            size: 40,
          ),
          color: AppColors.primaryColor,
        ),
        const Spacer(),
        Text(
          '👋 اهلًا بك دكتور مريم  ',
          style: TextStyles.bold23.copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
