import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/more_cubit/more_state.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';

class MoreCubit extends Cubit<MoreState> {
  final AuthRepo authRepo;

  MoreCubit(
    this.authRepo,
  ) : super(MoreInitialState());

  final TextEditingController updatedNameController = TextEditingController();
  final TextEditingController updatedAgeController = TextEditingController();
  final TextEditingController updatedPhoneController = TextEditingController();
  final TextEditingController updatedSpecializationController =
      TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hasChanges = false;
  Future<void> updateUserProfile(
      {String? name, String? phone, int? age, String? specialization}) async {
    emit(UpdateUserProfileLoadingState());
    var result = await authRepo.updateUserProfile(
        name: name, phone: phone, age: age, specialization: specialization);

    result.fold(
        (failure) =>
            emit(UpdateUserProfileFailureState(errorMessage: failure.message)),
        (success) => emit(UpdateUserProfileSuccessState()));
  }

  Future<void> changeUserPassword(
      {required String oldPassword, required String newPassword}) async {
    emit(ChangeUserPasswordLoadingState());
    var result = await authRepo.changeUserPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    result.fold(
        (failure) =>
            emit(ChangeUserPasswordFailureState(errorMessage: failure.message)),
        (success) => emit(ChangeUserPasswordSuccessState()));
  }

  Future<void> logOut() async {
    var result = await authRepo.logout();
    result.fold(
        (failure) => emit(LogOutFailureState(errorMessage: failure.message)),
        (success) => emit(LogOutSuccessState()));
  }

  void userMakeChanges() {
    hasChanges = true;
    emit(UserMakeChangesInProfile());
  }
}
