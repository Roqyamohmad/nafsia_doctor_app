import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;
import 'package:nafsia_app/core/widgets/custom_doctor_post_details.dart';
import 'package:nafsia_app/core/widgets/custom_post_actions.dart'
    show CustomPostActions;
import 'package:nafsia_app/core/widgets/custom_post_image.dart'
    show CustomPostImage;

class CustomPostItem extends StatelessWidget {
  const CustomPostItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Card(
          color: const Color(0xffF7F4FA),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomDoctorPostDetails(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0.h),
                  child: Text(
                    '1 ساعة',
                    style: TextStyles.semiBold16.copyWith(color: Colors.grey),
                  ),
                ),
                const Text(
                  'يتميز الاضطراب النفسي باختلال سريري جسيم في إدراك الفرد أو ضبطه لمشاعره أو سلوكه، وعادة ما يرتبط بالكرب أو بقصور في مجالات مهمة من الأداء، ',
                  style: TextStyles.regular16,
                ),
                verticalSpace(16),
                const CustomPostImage(),
                verticalSpace(12),
                const CustomPostActions()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
