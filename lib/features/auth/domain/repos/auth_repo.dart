import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, dynamic>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required int age,
    required String gender,
    required String phoneNumber,
    required String specialty,
    required MultipartFile profileImage,
    required MultipartFile licenseImage,
  });

  Future<Either<Failure, void>> logIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> forgetPassword({
    required String email,
  });

  Future<Either<Failure, void>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, void>> resetPassword({
    required String otp,
    required String newPassword,
  });
}
