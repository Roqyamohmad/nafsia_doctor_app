// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/signup_cubits/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required int age,
    required String gender,
    required String phoneNumber,
    required String specialty,
    required MultipartFile profileImage,
    required MultipartFile licenseImage,
  }) async {
    emit(SignupLoading());

    try {
      final result = await authRepo.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        age: age,
        gender: gender,
        phoneNumber: phoneNumber,
        specialty: specialty,
        profileImage: profileImage,
        licenseImage: licenseImage,
      );

      result.fold((failure) {
        emit(SignupFailure(message: failure.message));
      }, (_) {
        emit(SignupSuccess(message: 'تم إنشاء الحساب بنجاح'));
      });
    } catch (e) {
      emit(SignupFailure(message: e.toString()));
    }
  }
}
