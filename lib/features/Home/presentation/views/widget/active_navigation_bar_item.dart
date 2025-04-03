import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nafsia_app/core/helper_functions/is_device_in_portrait.dart'
    show isDeviceInPortrait;
import 'package:nafsia_app/core/utils/app_colors.dart' show AppColors;

import '../../../../../core/utils/app_text_styles.dart';

class ActiveNavigationItem extends StatelessWidget {
  const ActiveNavigationItem(
      {super.key, required this.image, required this.title});
  final String image, title;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsetsDirectional.only(end: 16),
        height: isDeviceInPortrait(context) ? 40.h : 90.h,
        decoration: ShapeDecoration(
            color: const Color(0xffEEEEEE),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Row(
          children: [
            Container(
              height: isDeviceInPortrait(context) ? 40.h : 80.h,
              width: 40.w,
              padding: const EdgeInsets.all(5),
              decoration: ShapeDecoration(
                //color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: SvgPicture.asset(
                image,
              ),
            ),
            Text(
              title,
              style: TextStyles.semiBold13.copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
