import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';
import 'package:nafsia_app/features/Home/data/repos/appointment_repo.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo repository;
  List<AppointmentDataModel> appointment = [];
  AppointmentCubit(this.repository) : super(AppointmentInitial());

  Future<void> createAppointment({
    required String day,
    required String startAtHour,
    required int duration,
    required int price,
  }) async {
    emit(AppointmentLoading());
    try {
      final result = await repository.createAppointment(
        day: day,
        startAtHour: startAtHour,
        duration: duration,
        price: price,
      );

      result.fold(
        (failure) {
          emit(AppointmentFailure(failure.message));
        },
        (appointment) {
          print('Created appointment id: ${appointment.id}');
          emit(AppointmentSuccess(appointment));
        },
      );
    } catch (e) {
      emit(AppointmentFailure('حدث خطأ غير متوقع أثناء الإضافة: $e'));
    }
  }

  Future<void> updateAppointment({
    required String appointmentId,
    required String day,
    required String startAtHour,
    required int duration,
    required int price,
  }) async {
    emit(AppointmentLoading());
    try {
      final result = await repository.updateAppointment(
        appointmentId: appointmentId,
        day: day,
        startAtHour: startAtHour,
        duration: duration,
        price: price,
      );

      result.fold(
        (failure) {
          emit(AppointmentFailure(failure.message));
        },
        (appointment) {
          emit(AppointmentUpdated(appointment));
        },
      );
    } catch (e) {
      emit(AppointmentFailure('حدث خطأ غير متوقع أثناء التحديث: $e'));
    }
  }

  Future<void> deleteAppointment({required String postId}) async {
    emit(DeleteAppointmentLoadingState());
    final result = await repository.deleteAppointment(postId: postId);

    result.fold(
      (failure) {
        // ✅ لو السيرفر قال إن المنشور مش موجود، نمسحه محليًا كأنه اتحذف
        if (failure.message.contains("غير موجود")) {
          appointment.removeWhere((appointment) => appointment.id == postId);
          emit(DeleteAppointmentSuccessState());
          emit(GetAllAppointmentSuccessState(
              appointment: List.from(appointment)));
        } else {
          // ❌ مشكلة تانية فعلاً حصلت
          emit(DeleteAppointmentFailureState(failure.message));
        }
      },
      (_) async {
        // ✅ حذف ناجح
        appointment.removeWhere((post) => post.id == postId);
        emit(DeleteAppointmentSuccessState());
        emit(
            GetAllAppointmentSuccessState(appointment: List.from(appointment)));
      },
    );
  }

  Future<void> getAllAppointments() async {
    emit(AppointmentLoading());
    try {
      final result = await repository.getAppointments();

      result.fold(
        (failure) {
          emit(AppointmentFailure(failure.message));
        },
        (appointments) {
          appointment = appointments;
          emit(AppointmentsLoaded(appointments));
        },
      );
    } catch (e) {
      emit(AppointmentFailure('حدث خطأ غير متوقع أثناء الجلب: $e'));
    }
  }
}
