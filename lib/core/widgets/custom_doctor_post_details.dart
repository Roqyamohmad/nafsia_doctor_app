import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/features/Home/data/model/doctor_data_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'custom_cached_network_image.dart';

class CustomDoctorPostDetails extends StatelessWidget {
  final DoctorDataModel doctorData;
  final DateTime createdAt;

  const CustomDoctorPostDetails(
      {super.key, required this.doctorData, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCachedNetworkImageWidget(
          imageUrl: doctorData.avatarUrl,
          borderRadius: 8,
          height: 40.h,
          fit: BoxFit.cover,
        ),
        horizontalSpace(8),
        Text(
          doctorData.name,
          style: TextStyles.semiBold16,
        ),
        Text(
          timeago.format(createdAt, locale: 'ar'),
          style: TextStyles.semiBold16.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
