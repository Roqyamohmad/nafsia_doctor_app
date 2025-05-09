import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_images.dart';
import 'package:nafsia_app/core/utils/spacing.dart';

import '../../../../../core/utils/app_text_styles.dart';
import '../../../../auth/data/models/user_model.dart';

class CustomMoreViewHeader extends StatelessWidget {
  const CustomMoreViewHeader({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.primaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
        Positioned(
          top: 40.h,
          left: 0,
          right: 0,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50.r,
                child: CircleAvatar(
                  radius: 48.r,
                  backgroundImage:
                      const AssetImage(Assets.assetsImagesPostTestImage),
                ),
              ),
              verticalSpace(12),
              Text(
                user.name!,
                style: TextStyles.bold19.copyWith(color: Colors.white),
              ),
              Text(
                user.email!,
                style: TextStyles.regular14.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
