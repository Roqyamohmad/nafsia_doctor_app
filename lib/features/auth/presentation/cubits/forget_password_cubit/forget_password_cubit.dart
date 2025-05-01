import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';

import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepo authRepo;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  ForgetPasswordCubit(this.authRepo) : super(ForgetPasswordInitialState());
  Timer? _resendTimer;
  int _remainingSeconds = 0;
  int _currentCooldown = 60; // starts with 60 seconds
  int get remainingSeconds => _remainingSeconds;
  bool get canResend => _remainingSeconds == 0;
  Future<void> sendResetCode({required String email}) async {
    emit(ForgetPasswordLoadingState());

    final result = await authRepo.forgetPassword(email: email);
    result.fold(
      (failure) =>
          emit(ForgetPasswordFailureState(errorMessage: failure.message)),
      (_) {
        _startResendCodeDown();
        emit(ForgetPasswordSuccessState());
      },
    );
  }

  void _startResendCodeDown() {
    _remainingSeconds = _currentCooldown;
    _resendTimer?.cancel();

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        emit(ResendCooldownTickState(remaining: _remainingSeconds));
      } else {
        timer.cancel();
        _currentCooldown *= 2;
        emit(ResendCooldownFinishedState());
      }
    });
  }

  Future<void> verifyOtp({required String email}) async {
    emit(OtpVerificationLoadingState());
    final result =
        await authRepo.verifyOtp(email: email, otp: otpController.text);
    result.fold(
      (failure) =>
          emit(OtpVerificationFailureState(errorMessage: failure.message)),
      (_) => emit(OtpVerificationSuccessState()),
    );
  }

  Future<void> resetPassword({required String otp}) async {
    emit(ResetPasswordLoadingState());
    final result = await authRepo.resetPassword(
        otp: otp, newPassword: newPasswordController.text);
    result.fold(
      (failure) =>
          emit(ResetPasswordFailureState(errorMessage: failure.message)),
      (_) => emit(ResetPasswordSuccessState()),
    );
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
