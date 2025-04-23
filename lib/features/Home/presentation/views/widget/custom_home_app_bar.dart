import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart' show AppColors;
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;
import 'package:nafsia_app/features/Home/presentation/views/widget/notification_view.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' اهلًا بك دكتور مريم  ^_^ ',
          style: TextStyles.bold23.copyWith(color: AppColors.primaryColor),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationView()),
            );
          },
          icon: const Icon(
            Icons.notifications_rounded,
            size: 40,
          ),
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
