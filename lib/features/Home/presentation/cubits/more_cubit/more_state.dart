sealed class MoreState {}

final class MoreInitialState extends MoreState {}

final class UpdateUserProfileLoadingState extends MoreState {}

final class UpdateUserProfileSuccessState extends MoreState {}

final class UpdateUserProfileFailureState extends MoreState {
  final String errorMessage;
  UpdateUserProfileFailureState({required this.errorMessage});
}

final class UserMakeChangesInProfile extends MoreState {}

final class ChangeUserPasswordLoadingState extends MoreState {}

final class ChangeUserPasswordFailureState extends MoreState {
  final String errorMessage;
  ChangeUserPasswordFailureState({required this.errorMessage});
}

final class ChangeUserPasswordSuccessState extends MoreState {}

final class LogOutFailureState extends MoreState {
  final String errorMessage;
  LogOutFailureState({required this.errorMessage});
}

final class LogOutSuccessState extends MoreState {}
