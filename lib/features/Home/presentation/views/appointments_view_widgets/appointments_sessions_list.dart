import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appintment_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appointment_state.dart';

import 'appointment_card_session.dart';

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
