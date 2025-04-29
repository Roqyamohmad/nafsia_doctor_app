import 'package:bloc/bloc.dart';
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
    String? imagePath,
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
        imagePath: imagePath,
      );

      result.fold(
        (failure) {
          emit(SignupFailure(message: failure.message));
          print('Signup failed: ${failure.message}');
        },
        (userModel) {
          emit(SignupSuccess(message: userModel.message));
          print('Signup success: ${userModel.message}');
        },
      );
    } catch (e) {
      emit(SignupFailure(message: e.toString()));
      print('Unexpected error during signup: $e');
    }
  }
}
