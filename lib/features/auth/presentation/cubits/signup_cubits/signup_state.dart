
abstract class SignupState {}

class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final String message;
  SignupSuccess({ required this.message});
}

final class SignupFailure extends SignupState {
  final String message;
  SignupFailure({required this.message});
}
