import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/helper_functions/support_group_utils.dart'
    show calculateSessionDuration, formatSupportGroupDate;
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/Home/domain/entities/support_group_entity.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/seat_selection.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/time_selection.dart';

Future<SupportGroupDataEntity?> showSupportGroupsView(BuildContext context) {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  int selectedSeats = 1;
  TimeOfDay selectedTime = const TimeOfDay(hour: 6, minute: 30);

  return showDialog<SupportGroupDataEntity>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.r),
            ),
            title: const Text(
              "تفاصيل الجلسة",
              textAlign: TextAlign.center,
              style: TextStyles.bold23,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: titleController,
                  labelText: "اسم مجموعة الدعم",
                  textInputType: TextInputType.text,
                ),
                verticalSpace(12),
                SeatSelection(
                  selectedSeats: selectedSeats,
                  onSeatsChanged: (value) => setState(() {
                    selectedSeats = value;
                  }),
                ),
                verticalSpace(12),
                TimeSelection(
                  selectedTime: selectedTime,
                  onTimeSelected: (value) => setState(() {
                    selectedTime = value;
                  }),
                ),
                verticalSpace(12),
                CustomTextFormField(
                  controller: priceController,
                  labelText: "سعر الجلسة",
                  textInputType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("إلغاء"),
              ),
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  final priceText = priceController.text.trim();

                  if (title.isEmpty || priceText.isEmpty) return;

                  final date = formatSupportGroupDate(selectedTime);
                  final duration = calculateSessionDuration(selectedTime);

                  Navigator.pop(
                    context,
                    SupportGroupDataEntity(
                      title: title,
                      date: date,
                      duration: duration,
                      seats: selectedSeats,
                      price: double.tryParse(priceText) ?? 0,
                    ),
                  );
                },
                child: const Text("متابعة"),
              ),
            ],
          );
        },
      );
    },
  );
}
