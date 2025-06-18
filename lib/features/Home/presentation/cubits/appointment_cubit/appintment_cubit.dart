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
    required int duration,
    required int price,
    required List<ScheduleItem> schedule,
  }) async {
    emit(AppointmentLoading());
    try {
      final result = await repository.createAppointment(
        day: day,
        duration: duration,
        price: price,
        schedule: schedule,
      );

      result.fold(
        (failure) {
          emit(AppointmentFailure(failure.message));
        },
        (newAppointment) {
          print('Created appointment id: ${newAppointment.id}');

          // ✅ تحديث القائمة الحالية مباشرة بدون إخفائها
          appointment.add(newAppointment);

          emit(AppointmentSuccess(newAppointment));

          // ✅ إعادة إرسال الحالة الحالية بالقائمة المعدّلة
          emit(GetAllAppointmentSuccessState(
            appointment: List.from(appointment),
          ));
        },
      );
    } catch (e) {
      emit(AppointmentFailure('حدث خطأ غير متوقع أثناء الإضافة: $e'));
    }
  }

  Future<void> updateAppointment({
    required String appointmentId,
    required String day,
    required int duration,
    required int price,
    required List<ScheduleItem> schedule,
  }) async {
    emit(AppointmentLoading());
    try {
      final result = await repository.updateAppointment(
        appointmentId: appointmentId,
        day: day,
        schedule: schedule,
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

  Future<void> getAllAppointments() async {
    emit(GetAllAppointmentLoadingState());
    try {
      final result = await repository.getAppointments();

      result.fold(
        (failure) {
          emit(AppointmentFailure(failure.message));
        },
        (appointments) {
          appointment = appointments;
          emit(GetAllAppointmentSuccessState(
              appointment: List.from(appointment)));
        },
      );
    } catch (e) {
      emit(AppointmentFailure('حدث خطأ غير متوقع أثناء الجلب: $e'));
    }
  }

  Future<void> deleteAppointment({required String appointmentId}) async {
    emit(DeleteAppointmentLoadingState());
    final result =
        await repository.deleteAppointment(appointmentId: appointmentId);

    result.fold(
      (failure) {
        // ✅ لو السيرفر قال إن المنشور مش موجود، نمسحه محليًا كأنه اتحذف
        if (failure.message.contains("غير موجود")) {
          appointment
              .removeWhere((appointment) => appointment.id == appointmentId);
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
        appointment.removeWhere((post) => post.id == appointmentId);
        emit(DeleteAppointmentSuccessState());
        emit(
            GetAllAppointmentSuccessState(appointment: List.from(appointment)));

        // ✅ (اختياري) تحدث البوستات من السيرفر لو حابب تضمن أحدث نسخة
        await getAllAppointments();
      },
    );
  }

  Future<void> markSessionComplete(String sessionId) async {
    emit(MarkSessionCompleteLoading());
    final result = await repository.markSessionComplete(sessionId: sessionId);
    result.fold(
      (failure) => emit(MarkSessionCompleteError(
        errorMessage: failure.message,
      )),
      (success) => emit(MarkSessionCompleteSuccess()),
    );
  }
}
