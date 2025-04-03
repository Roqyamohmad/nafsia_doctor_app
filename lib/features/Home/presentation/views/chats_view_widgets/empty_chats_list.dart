import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nafsia_app/core/utils/app_images.dart' show Assets;
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;
import 'package:nafsia_app/core/widgets/custom_button.dart' show CustomButton;
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/support_groups_view.dart';

class EmptyChatsList extends StatelessWidget {
  const EmptyChatsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          verticalSpace(
            24,
          ),
          CustomButton(
              text: 'إتشأ مجموعة الدعم',
              onPressed: () {
                Navigator.pushNamed(context, SupportGroupsView.routename);
              }),
        ],
      ),
    );
  }
}
