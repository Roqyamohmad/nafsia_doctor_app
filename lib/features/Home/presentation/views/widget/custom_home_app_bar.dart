import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart' show AppColors;
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;
import 'package:nafsia_app/features/Home/presentation/views/widget/notification_view.dart';
import 'package:nafsia_app/features/auth/data/models/user_model.dart';

// ignore: must_be_immutable
class CustomHomeAppBar extends StatelessWidget {
  final User? doctorData;
  const CustomHomeAppBar({
    this.doctorData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.001),
          child: Text(
            '  اهلًا بك دكتور ${doctorData!.name}   ^_^',
            style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
          ),
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
