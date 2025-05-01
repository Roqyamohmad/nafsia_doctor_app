abstract class ForgetPasswordState {}

final class ForgetPasswordInitialState extends ForgetPasswordState {}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}

final class ForgetPasswordSuccessState extends ForgetPasswordState {}

final class ForgetPasswordFailureState extends ForgetPasswordState {
  final String errorMessage;
  ForgetPasswordFailureState({required this.errorMessage});
}

final class OtpVerificationSuccessState extends ForgetPasswordState {}

final class OtpVerificationLoadingState extends ForgetPasswordState {}

final class OtpVerificationFailureState extends ForgetPasswordState {
  final String errorMessage;
  OtpVerificationFailureState({required this.errorMessage});
}

final class ResetPasswordLoadingState extends ForgetPasswordState {}

final class ResetPasswordSuccessState extends ForgetPasswordState {}

final class ResetPasswordFailureState extends ForgetPasswordState {
  final String errorMessage;
  ResetPasswordFailureState({required this.errorMessage});
}

class ResendCooldownTickState extends ForgetPasswordState {
  final int remaining;
  ResendCooldownTickState({required this.remaining});
}

class ResendCooldownFinishedState extends ForgetPasswordState {}
