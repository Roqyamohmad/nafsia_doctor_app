import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/widgets/timezone_helper.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appintment_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appointment_state.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/index.dart';
import 'package:uuid/uuid.dart';

import 'package:nafsia_app/core/widgets/custom_text_field.dart';

class DoctorSessionDialog extends StatefulWidget {
  final AppointmentDataModel? existingAppointment;

  const DoctorSessionDialog({
    super.key,
    this.existingAppointment,
  });

  @override
  State<DoctorSessionDialog> createState() => _DoctorSessionDialogState();
}

class _DoctorSessionDialogState extends State<DoctorSessionDialog> {
  TimeOfDay? selectedFromTime;
  int? selectedDuration;
  final TextEditingController priceController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.existingAppointment != null) {
      final existing = widget.existingAppointment!;
      if (existing.day != null) {
        selectedDate = DateTime.tryParse(existing.day!);
      }
      final scheduleList = existing.schedule;
      if (scheduleList != null && scheduleList.isNotEmpty) {
        final startAt = scheduleList.first.startAt;
        if (startAt != null) {
          final parts = startAt.split(':');
          selectedFromTime = TimeOfDay(
            hour: int.tryParse(parts[0]) ?? 0,
            minute: int.tryParse(parts[1]) ?? 0,
          );
        }
      }
      priceController.text = existing.price?.toString() ?? '';
      // ✅ لا نحمل المدة القديمة، سيتم حسابها من الـ selector
      selectedDuration = null;
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
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(isUpdateMode ? 'تم التحديث بنجاح' : 'تم الإضافة بنجاح'),
            ),
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
                SessionTimeSelector(
                  onTimeSelected: (startAt, duration) {
                    setState(() {
                      selectedFromTime = startAt;
                      selectedDuration = duration;
                    });
                  },
                  initialStartAt: selectedFromTime,
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    selectedDate == null
                        ? 'اختر تاريخ الجلسة'
                        : 'التاريخ المختار: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                  ),
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
                onPressed: () => _onDeletePressed(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('حذف', style: TextStyle(color: Colors.white)),
              ),
            ElevatedButton(
              onPressed: () => _onSaveOrUpdatePressed(context, isUpdateMode),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(isUpdateMode ? 'تحديث' : 'حفظ',
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _onSaveOrUpdatePressed(BuildContext context, bool isUpdateMode) async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك اختر تاريخ الجلسة')),
      );
      return;
    }

    if (selectedFromTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك اختر وقت الجلسة')),
      );
      return;
    }

    if (selectedDuration == null || selectedDuration == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك اختر مدة الجلسة')),
      );
      return;
    }

    if (priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك أدخل سعر الجلسة')),
      );
      return;
    }

    final cubit = context.read<AppointmentCubit>();

    // ✅ استخدم توقيت القاهرة بدقة
    final fullDateTimeCairo = TimezoneHelper.createCairoDateTime(
      selectedDate!,
      selectedFromTime!.hour,
      selectedFromTime!.minute,
    );

    final fullDateTimeUtc = fullDateTimeCairo.toUtc();
    final nowUtc = DateTime.now().toUtc();

    if (fullDateTimeUtc.isBefore(nowUtc)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يمكن اختيار موعد في الماضي')),
      );
      return;
    }

    final dayFormatted = fullDateTimeUtc.toIso8601String();

    final startAtHour = formatTimeOfDay24(selectedFromTime!);
    final duration = selectedDuration!;
    final price = int.tryParse(priceController.text) ?? 0;

    final uuid = Uuid();
    final List<ScheduleItem> schedule = [
      ScheduleItem(
        id: uuid.v4(),
        startAt: startAtHour,
        isBooked: false,
      ),
    ];

    if (isUpdateMode) {
      cubit.updateAppointment(
        appointmentId: widget.existingAppointment!.id!,
        day: dayFormatted,
        schedule: schedule,
        duration: duration,
        price: price,
      );
    } else {
      cubit.createAppointment(
        day: dayFormatted,
        schedule: schedule,
        duration: duration,
        price: price,
      );
    }
  }

  void _onDeletePressed(BuildContext context) {
    final cubit = context.read<AppointmentCubit>();
    cubit.deleteAppointment(
      appointmentId: widget.existingAppointment!.id!,
    );
  }

  String formatTimeOfDay24(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
