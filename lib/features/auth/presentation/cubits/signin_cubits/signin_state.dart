abstract class SigninState {}

final class SigninInitialState extends SigninState {}

final class SigninSuccessState extends SigninState {
  final String message;
  SigninSuccessState({required this.message});
}

final class SigninLoadingState extends SigninState {}

final class SigninFailureState extends SigninState {
  final String message;

  SigninFailureState({required this.message});
}
