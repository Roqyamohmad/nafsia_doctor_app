import 'package:nafsia_app/features/Home/data/model/appointement_data_model.dart';

abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSuccess extends AppointmentState {
  final AppointmentDataModel appointment;
  AppointmentSuccess(this.appointment);
}

class AppointmentFailure extends AppointmentState {
  final String error;
  AppointmentFailure(this.error);
}

class AppointmentUpdated extends AppointmentState {
  final AppointmentDataModel appointment;
  AppointmentUpdated(this.appointment);
}

class AppointmentDeleted extends AppointmentState {}

class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentDataModel> appointments;
  AppointmentsLoaded(this.appointments);
}

class DeleteAppointmentLoadingState extends AppointmentState {}

class DeleteAppointmentSuccessState extends AppointmentState {}

class DeleteAppointmentFailureState extends AppointmentState {
  final String message;
  DeleteAppointmentFailureState(this.message);
}

final class GetAllAppointmentLoadingState extends AppointmentState {}

final class GetAllAppointmentSuccessState extends AppointmentState {
  final List<AppointmentDataModel> appointment;
  GetAllAppointmentSuccessState({required this.appointment});
}

final class GetAllAppointmentFailureState extends AppointmentState {
  final String errorMessage;
  GetAllAppointmentFailureState({required this.errorMessage});
}
