import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appintment_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/views/profile_view_widgets/change_appointment_view_body.dart';

class ChangeAppointmentView extends StatelessWidget {
  const ChangeAppointmentView({super.key});
  static const routeName = 'change-appointment-view';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppointmentCubit(getIt<AppointmentRepo>()..getAppointments()),
      child: const ChangeAppointmentViewBody(),
    );
  }
}
