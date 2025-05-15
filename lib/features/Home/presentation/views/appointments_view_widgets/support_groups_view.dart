import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_state.dart';
import 'package:nafsia_app/features/Home/presentation/views/appointments_view_widgets/seat_selection.dart';
import 'package:nafsia_app/features/Home/presentation/views/appointments_view_widgets/time_selection.dart';
import 'package:nafsia_app/features/Home/data/model/community_session_model.dart';

Future<CommunitySessionModel?> showSupportGroupsView(BuildContext context) {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final meetLinkController = TextEditingController();
  final descriptionController = TextEditingController();
  int selectedSeats = 1;
  TimeOfDay selectedStartTime = const TimeOfDay(hour: 6, minute: 30);
  TimeOfDay selectedEndTime = const TimeOfDay(hour: 7, minute: 30);
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  List<String> tags = [];

  final cubit = context.read<CommunitySessionCubit>();
  // BuildContext? dialogContext;

  return showDialog<CommunitySessionModel>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      // dialogContext = context; // حفظ سياق الـ dialog
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<CommunitySessionCubit, CommunitySessionState>(
          listener: (context, state) {
            if (state is CommunitySessionSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تمت إضافة الجلسة بنجاح')),
              );
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
                      CustomTextFormField(
                        maxLines: 5,
                        controller: descriptionController,
                        labelText: "وصف مجموعة الدعم",
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
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedStartDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  selectedStartDate = pickedDate;
                                  selectedEndDate = pickedDate;
                                });
                              }
                            },
                            child: Text(
                              "${selectedStartDate.toLocal()}".split(' ')[0],
                            ),
                          ),
                          Text(
                            "      تاريخ الجلسة",
                            style: TextStyles.bold16,
                          ),
                        ],
                      ),
                      verticalSpace(12),
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
                          SizedBox(width: 8),
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
                            : () async {
                                final title = titleController.text.trim();
                                final priceText = priceController.text.trim();
                                final meetLink = meetLinkController.text.trim();

                                if (title.isEmpty ||
                                    priceText.isEmpty ||
                                    meetLink.isEmpty) return;

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

                                final price = int.tryParse(priceText) ?? 0;

                                context
                                    .read<CommunitySessionCubit>()
                                    .createCommunitySession(
                                      tags: tags.isEmpty ? [] : tags,
                                      description: descriptionController.text
                                              .trim()
                                              .isNotEmpty
                                          ? descriptionController.text.trim()
                                          : 'لا يوجد وصف',
                                      meetLink: meetLink.isNotEmpty
                                          ? meetLink
                                          : 'https://defaultlink.com',
                                      startAt: startAt,
                                      duration: durationInMinutes,
                                      seats: selectedSeats,
                                      price: price,
                                      title: title,
                                    );
                                final lastSessionId = cubit.sessions.last.id;

                                // تأكيد: لو عايز تعمل fetch من السيرفر مرة كمان
                                await cubit
                                    .getCommunitySessionById(lastSessionId);
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
