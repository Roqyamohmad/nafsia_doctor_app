import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/utils/app_images.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart';

class CustomDoctorPostDetails extends StatelessWidget {
  const CustomDoctorPostDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.assetsImagesProfileTestImage,
          height: 40.h,
          fit: BoxFit.fitHeight,
        ),
        horizontalSpace(8),
        const Text(
          'د/عبد الرحمن محمد',
          style: TextStyles.semiBold16,
        ),
      ],
    );
  }
}
