import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/constants.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appintment_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/views/appointments_view_widgets/show_doctor_session_dialog.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_main_view_app_bar.dart'
    show CustomMainViewsAppBar;
import 'package:nafsia_app/features/Home/presentation/views/appointments_view_widgets/appointments_sessions_list.dart';

class AppointmentsViewBody extends StatefulWidget {
  const AppointmentsViewBody({super.key});

  @override
  State<AppointmentsViewBody> createState() => _AppointmentsViewBodyState();
}

class _AppointmentsViewBodyState extends State<AppointmentsViewBody> {
  late AppointmentCubit appointmentCubit;

  @override
  void initState() {
    super.initState();
    appointmentCubit = AppointmentCubit(getIt<AppointmentRepo>());
    appointmentCubit.getAllAppointments(); // تحميل مواعيد الدكتور فقط
  }

  @override
  void dispose() {
    appointmentCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: appointmentCubit,
      child: Scaffold(
        // ✅ أضف Scaffold هنا
        floatingActionButton: FloatingActionButton.extended(
          // ✅ الزر هنا
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) => BlocProvider.value(
                value: appointmentCubit,
                child: const DoctorSessionDialog(),
              ),
            );
          },
          icon: const Icon(
            Icons.calendar_today,
            color: AppColors.primaryColor,
          ),
          label: Text(
            'إضافة جلسة',
            style: TextStyles.medium15.copyWith(color: AppColors.primaryColor),
          ),
          backgroundColor: AppColors.backGroundyColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: ListView(
            children: [
              const CustomMainViewsAppBar(title: 'المواعيد'),
              verticalSpace(8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "مواعيد السيشنات",
                  style:
                      TextStyles.bold16.copyWith(color: AppColors.primaryColor),
                ),
              ),
              SizedBox(
                height: height * 0.9,
                child: AppointmentsSessionsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
