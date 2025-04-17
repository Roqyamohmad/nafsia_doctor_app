import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nafsia_app/core/utils/app_images.dart' show Assets;
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;

class EmptyChatsList extends StatelessWidget {
  const EmptyChatsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.assetsImagesChatsActive,
              height: 50.h,
            ),
            verticalSpace(16),
            const Text(
              'ليس لديك محادثات مفتوحة',
              style: TextStyles.bold19,
            ),
          ],
        ),
      ),
    );
  }
}
