import 'package:flutter/material.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/session_day_selector.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/session_time_selector.dart';
//import 'package:nafsia_app/features/auth/presentation/views/widget/session_price_field.dart';

void showDoctorSessionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('مواعيد الجلسة'),
      // ignore: prefer_const_constructors
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SessionDaySelector(),
          SizedBox(height: 12),
          SessionTimeSelector(),
          SizedBox(height: 12),
          CustomTextFormField(
            //controller: priceController,
            labelText: "سعر الجلسه",
            textInputType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('حفظ'),
        ),
      ],
    ),
  );
}
