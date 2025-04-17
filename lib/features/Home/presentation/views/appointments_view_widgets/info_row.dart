import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget infoRow(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.only(top: 4.h),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14.sp),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
