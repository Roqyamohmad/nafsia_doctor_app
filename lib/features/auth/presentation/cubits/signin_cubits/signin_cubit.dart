// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';
import 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitialState());

  final AuthRepo authRepo;

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    emit(SigninLoadingState());

    try {
      final result = await authRepo.logIn(
        email: email,
        password: password,
      );

      result.fold((failure) {
        emit(SigninFailureState(message: failure.message));
      }, (userModel) {
        emit(SigninSuccessState(message: 'تم تسجيل الدخول بنجاح'));
      });
    } catch (e) {
      emit(SigninFailureState(message: e.toString()));
    }
  }
}
