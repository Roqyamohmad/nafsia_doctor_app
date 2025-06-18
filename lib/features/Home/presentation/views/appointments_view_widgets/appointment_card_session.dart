import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appintment_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appointment_state.dart';

class AppointmentCardSessions extends StatefulWidget {
  final AppointmentDataModel appointment;

  const AppointmentCardSessions({super.key, required this.appointment});

  @override
  State<AppointmentCardSessions> createState() =>
      _AppointmentCardSessionsState();
}

class _AppointmentCardSessionsState extends State<AppointmentCardSessions> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = _isSessionCompleted(widget.appointment);
  }

  void _markAsCompleted() async {
    final cubit = context.read<AppointmentCubit>();

    await cubit.markSessionComplete(widget.appointment.id!);

    final state = cubit.state;
    if (state is MarkSessionCompleteSuccess) {
      setState(() {
        isCompleted = true;
        widget.appointment.status != 'completed'; // ✅ تحديث الحالة محليًا
      });
    } else if (state is MarkSessionCompleteError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointment = widget.appointment;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // التاريخ + الحالة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 20, color: Colors.teal),
                    const SizedBox(width: 8),
                    Text(
                      'اليوم: ${_formatDay(appointment.day)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                isCompleted
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '✅ مكتملة',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    : _canBeCompleted(appointment)
                        ? ElevatedButton.icon(
                            onPressed: () => _markAsCompleted(),
                            icon: const Icon(Icons.check, size: 16),
                            label: const Text('تحديد كمكتملة'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                          )
                        : const Text(
                            '⏳ لم تبدأ بعد',
                            style: TextStyle(color: Colors.grey),
                          )
              ],
            ),

            const SizedBox(height: 8),

            // المدة والسعر
            Row(
              children: [
                const Icon(Icons.timer, size: 20, color: Colors.orange),
                const SizedBox(width: 8),
                Text('المدة: ${appointment.duration} دقيقة'),
                const SizedBox(width: 16),
                const Icon(Icons.attach_money, size: 20, color: Colors.green),
                const SizedBox(width: 4),
                Text('السعر: ${appointment.price} جنيه'),
              ],
            ),
            const SizedBox(height: 12),

            const Text(
              '🕒 المواعيد:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            ...appointment.schedule!.map(
              (item) => Row(
                children: [
                  const Icon(Icons.access_time, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(item.startAt!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSessionCompleted(AppointmentDataModel appointment) {
    return appointment.status?.toLowerCase() == 'completed';
  }

  String _formatDay(String? isoString) {
    if (isoString == null) return '-';
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('d MMMM yyyy', 'ar').format(dateTime);
    } catch (e) {
      return isoString;
    }
  }

  bool _canBeCompleted(AppointmentDataModel appointment) {
    if (appointment.schedule == null || appointment.schedule!.isEmpty)
      return false;

    final firstSchedule = appointment.schedule!.first;
    if (firstSchedule.startAt == null) return false;

    final startTime = DateTime.tryParse(firstSchedule.startAt!);
    if (startTime == null) return false;

    final endTime = startTime.add(Duration(minutes: appointment.duration ?? 0));
    return DateTime.now().isAfter(endTime);
  }
}
