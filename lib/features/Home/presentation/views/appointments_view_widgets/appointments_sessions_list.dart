import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appintment_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appointment_state.dart';

class AppointmentsSessionsList extends StatelessWidget {
  const AppointmentsSessionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is GetAllAppointmentLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetAllAppointmentSuccessState) {
          final List<AppointmentDataModel> appointments = state.appointment;

          if (appointments.isEmpty) {
            return const Center(child: Text('لا توجد مواعيد حالياً.'));
          }

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return AppointmentCardSessions(appointment: appointment);
            },
          );
        } else if (state is AppointmentFailure) {
          return Center(
            child: Text('خطأ أثناء تحميل المواعيد: ${state.error}'),
          );
        }

        // حالة افتراضية
        return const SizedBox.shrink();
      },
    );
  }
}

class AppointmentCardSessions extends StatelessWidget {
  final AppointmentDataModel appointment;

  const AppointmentCardSessions({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
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
            // التاريخ
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  'اليوم: ${_formatDay(appointment.day)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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

            // جدول المواعيد
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

  String _formatDay(String? isoString) {
    if (isoString == null) return '-';
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('d MMMM yyyy', 'ar')
          .format(dateTime); // مثال: 13 مايو 2025
    } catch (e) {
      return isoString;
    }
  }
}
