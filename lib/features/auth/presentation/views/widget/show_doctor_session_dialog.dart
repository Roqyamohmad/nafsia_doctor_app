import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/helper_functions/map_arabic_day_toEnglish.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appintment_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appointment_state.dart';

import 'session_day_selector.dart';
import 'session_time_selector.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';

class DoctorSessionDialog extends StatefulWidget {
  final AppointmentDataModel? existingAppointment;

  const DoctorSessionDialog({
    super.key,
    this.existingAppointment,
  });

  @override
  State<DoctorSessionDialog> createState() => DoctorSessionDialogState();
}

class DoctorSessionDialogState extends State<DoctorSessionDialog> {
  String? selectedDay;
  TimeOfDay? selectedFromTime;
  int? selectedDuration;
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingAppointment != null) {
      selectedDay = mapEnglishDayToArabic(widget.existingAppointment!.day!);
      selectedFromTime = TimeOfDay(
        hour: int.parse(widget.existingAppointment!.startAtHour!.split(':')[0]),
        minute:
            int.parse(widget.existingAppointment!.startAtHour!.split(':')[1]),
      );
      selectedDuration = widget.existingAppointment!.duration;
      priceController.text = widget.existingAppointment!.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdateMode = widget.existingAppointment != null;

    return BlocConsumer<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentSuccess ||
            state is AppointmentUpdated ||
            state is AppointmentDeleted) {
          Navigator.pop(context); // أغلق النافذة بعد العملية الناجحة
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    isUpdateMode ? 'تم التحديث بنجاح' : 'تم الإضافة بنجاح')),
          );
        } else if (state is AppointmentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(isUpdateMode ? 'تعديل الجلسة' : 'إضافة جلسة'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SessionDaySelector(
                  onDaySelected: (day) {
                    selectedDay = day;
                  },
                  initialDay: selectedDay,
                ),
                const SizedBox(height: 12),
                SessionTimeSelector(
                  onTimeSelected: (startAt, duration) {
                    selectedFromTime = startAt;
                    selectedDuration = duration;
                  },
                  initialStartAt: selectedFromTime,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  controller: priceController,
                  labelText: "سعر الجلسة",
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                if (state is AppointmentLoading)
                  const CircularProgressIndicator(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            if (isUpdateMode)
              ElevatedButton(
                onPressed: () {
                  _onDeletePressed(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('حذف'),
              ),
            ElevatedButton(
              onPressed: () {
                _onSaveOrUpdatePressed(context, isUpdateMode);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isUpdateMode ? Colors.white : Colors.blue,
              ),
              child: Text(isUpdateMode ? 'تحديث' : 'حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _onSaveOrUpdatePressed(BuildContext context, bool isUpdateMode) {
    if (selectedDay == null ||
        selectedFromTime == null ||
        priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك املأ كل الحقول')),
      );
      return;
    }

    final cubit = context.read<AppointmentCubit>();
    final dayInEnglish = mapArabicDayToEnglish(selectedDay!);
    final startAtHour = formatTimeOfDay24(selectedFromTime!);
    final duration = selectedDuration!;
    final price = int.tryParse(priceController.text) ?? 0;

    if (isUpdateMode) {
      cubit.updateAppointment(
        appointmentId: widget.existingAppointment!.id!,
        day: dayInEnglish,
        startAtHour: startAtHour,
        duration: duration,
        price: price,
      );
    } else {
      cubit.createAppointment(
        day: dayInEnglish,
        startAtHour: startAtHour,
        duration: duration,
        price: price,
      );
    }
  }

  void _onDeletePressed(BuildContext context) {
    final cubit = context.read<AppointmentCubit>();
    cubit.deleteAppointment(
      postId: widget.existingAppointment!.id!,
    );
  }

  String formatTimeOfDay24(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
