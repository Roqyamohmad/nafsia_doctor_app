import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/widgets/custom_animated_loading_widget.dart';
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appintment_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/appointment_cubit/appointment_state.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/show_doctor_session_dialog.dart';

class ChangeAppointmentViewBody extends StatefulWidget {
  const ChangeAppointmentViewBody({super.key});

  @override
  State<ChangeAppointmentViewBody> createState() =>
      _ChangeAppointmentViewBodyState();
}

class _ChangeAppointmentViewBodyState extends State<ChangeAppointmentViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentCubit>().getAllAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state is AppointmentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AppointmentsLoaded) {
              final appointments = state.appointments;
              if (appointments.isEmpty) {
                return const Center(child: Text('لا توجد مواعيد حالياً.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return AppointmentCard(appointment: appointment);
                },
              );
            } else if (state is AppointmentFailure) {
              return Center(child: Text('خطأ: ${state.error}'));
            }
            return const CustomAnimatedLoadingWidget();
          },
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final AppointmentDataModel appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text('اليوم: ${appointment.day ?? '-'}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الوقت: ${appointment.startAtHour ?? '-'}'),
            Text('المدة: ${appointment.duration} دقيقة'),
            Text('السعر: ${appointment.price} جنيه'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (context) =>
                          AppointmentCubit(getIt<AppointmentRepo>()),
                      child: DoctorSessionDialog(
                        existingAppointment: appointment,
                      ),
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                confirmdelete(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> confirmdelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (dialogContext) =>
          BlocListener<AppointmentCubit, AppointmentState>(
        bloc: context.read<AppointmentCubit>(), // هنا السر 👈
        listener: (context, state) {
          if (state is DeleteAppointmentSuccessState) {
            Navigator.pop(
                dialogContext); // نستخدم dialogContext مش context الأصلي
            ScaffoldMessenger.of(dialogContext).showSnackBar(
              const SnackBar(content: Text('تم حذف المنشور بنجاح')),
            );
          } else if (state is DeleteAppointmentFailureState) {
            ScaffoldMessenger.of(dialogContext).showSnackBar(
              SnackBar(content: Text('فشل حذف المنشور')),
            );
          }
        },
        child: AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد من حذف المنشور؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<AppointmentCubit>()
                    .deleteAppointment(postId: appointment.id!);
              },
              child: const Text('حذف'),
            ),
          ],
        ),
      ),
    );
  }
}
