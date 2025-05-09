import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/community_session_cubit.dart/community_session_cubit.dart';
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/features/Home/presentation/views/appointments_view_widgets/appointments_view_body.dart'; // تأكد من استيراد get_it

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommunitySessionCubit(getIt<AppointmentRepo>()), // إضافة BlocProvider
      child: const AppointmentsViewBody(),
    );
  }
}
