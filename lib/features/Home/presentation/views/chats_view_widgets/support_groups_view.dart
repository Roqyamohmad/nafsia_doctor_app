import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_state.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/seat_selection.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/time_selection.dart';
import 'package:nafsia_app/features/Home/data/model/community_session_model.dart';

Future<CommunitySessionModel?> showSupportGroupsView(BuildContext context) {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final meetLinkController = TextEditingController();
  int selectedSeats = 1;
  TimeOfDay selectedStartTime = const TimeOfDay(hour: 6, minute: 30);
  TimeOfDay selectedEndTime = const TimeOfDay(hour: 7, minute: 30); // جديد
  DateTime selectedStartDate = DateTime.now(); // جديد
  DateTime selectedEndDate = DateTime.now(); // جديد

  // احصل على الـ cubit قبل الدخول للـ showDialog
  final cubit = context.read<CommunitySessionCubit>();

  return showDialog<CommunitySessionModel>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider.value(
        value: cubit, // مررنا cubit هنا يدويًا
        child: BlocListener<CommunitySessionCubit, CommunitySessionState>(
          listener: (context, state) {
            if (state is CommunitySessionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تمت إضافة الجلسة بنجاح')),
              );
              Navigator.pop(context, state.session);
            } else if (state is CommunitySessionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('خطأ: ${state.error}')),
              );
            }
          },
          child: StatefulBuilder(
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
                content: SingleChildScrollView(
                  // استخدام التمرير
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        controller: titleController,
                        labelText: "اسم مجموعة الدعم",
                        textInputType: TextInputType.text,
                      ),
                      verticalSpace(12),
                      CustomTextFormField(
                        controller: meetLinkController,
                        labelText: "لينك مجموعة الدعم",
                        textInputType: TextInputType.text,
                      ),
                      verticalSpace(12),
                      SeatSelection(
                        selectedSeats: selectedSeats,
                        onSeatsChanged: (value) => setState(() {
                          selectedSeats = value;
                        }),
                      ),
                      // داخل Column:
                      verticalSpace(12),
// صف يحتوي على وقت البداية والنهاية
                      Row(
                        children: [
                          Expanded(
                            child: TimeSelection(
                              selectedTime: selectedStartTime,
                              onTimeSelected: (value) => setState(() {
                                selectedStartTime = value;
                              }),
                              label: "بداية الجلسة",
                            ),
                          ),
                          SizedBox(width: 8), // مسافة بسيطة بين العنصرين
                          Expanded(
                            child: TimeSelection(
                              selectedTime: selectedEndTime,
                              onTimeSelected: (value) => setState(() {
                                selectedEndTime = value;
                              }),
                              label: "نهاية الجلسة",
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(12),

                      CustomTextFormField(
                        controller: priceController,
                        labelText: "سعر الجلسة",
                        textInputType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("إلغاء"),
                  ),
                  BlocBuilder<CommunitySessionCubit, CommunitySessionState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is CommunitySessionLoading
                            ? null
                            : () {
                                final title = titleController.text.trim();
                                final priceText = priceController.text.trim();
                                final meetLink = meetLinkController.text.trim();

                                if (title.isEmpty ||
                                    priceText.isEmpty ||
                                    meetLink.isEmpty) return;

                                // حساب الـ duration بناءً على الفرق بين الوقتين
                                final startAt = DateTime(
                                  selectedStartDate.year,
                                  selectedStartDate.month,
                                  selectedStartDate.day,
                                  selectedStartTime.hour,
                                  selectedStartTime.minute,
                                );

                                final endAt = DateTime(
                                  selectedEndDate.year,
                                  selectedEndDate.month,
                                  selectedEndDate.day,
                                  selectedEndTime.hour,
                                  selectedEndTime.minute,
                                );

                                final durationInMinutes =
                                    endAt.difference(startAt).inMinutes;

                                context
                                    .read<CommunitySessionCubit>()
                                    .createCommunitySession(
                                      meetLink: meetLink,
                                      startAt: startAt,
                                      duration: durationInMinutes,
                                      seats: selectedSeats,
                                      price: int.tryParse(priceText) ?? 0,
                                    );
                              },
                        child: state is CommunitySessionLoading
                            ? const CircularProgressIndicator()
                            : const Text("متابعة"),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
