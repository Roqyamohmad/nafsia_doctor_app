import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/helper_functions/foramted_date.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/features/auth/data/models/user_model.dart';

import 'custom_user_information_item.dart';

class CustomAllUserInformation extends StatelessWidget {
  const CustomAllUserInformation({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          CustomUserInformationItem(
            title: 'رقم الهاتف: ',
            value: user.phone!,
          ),
          verticalSpace(12),
          CustomUserInformationItem(
            title: 'النوع: ',
            value: user.gender == 'male' ? 'ذكر' : 'انثى',
          ),
          verticalSpace(12),
          CustomUserInformationItem(
            title: 'العمر: ',
            value: user.age.toString(),
          ),
          verticalSpace(12),
          CustomUserInformationItem(
            title: 'تم التسجيل: ',
            value: formatDateFromDateTime(user.createdAt!),
          ),
        ],
      ),
    );
  }
}
