import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:nafsia_app/core/errors/custom_exceptions.dart';
import 'package:nafsia_app/core/errors/failures.dart';
import 'package:nafsia_app/core/services/api_consumer.dart' show ApiConsumer;
import 'package:nafsia_app/core/utils/backend_endpoint.dart';
import 'package:nafsia_app/features/auth/data/models/user_model.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';

import '../../../../core/helper_functions/cache_helper.dart';
import '../../../../core/utils/chache_helper_keys.dart';

class AuthRepoImpl extends AuthRepo {
  final ApiConsumer apiConsumer;
  AuthRepoImpl(this.apiConsumer);

  @override
  Future<Either<Failure, dynamic>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required int age,
    required String gender,
    required String phoneNumber,
    required String specialty,
    required String? imagePath,
  }) async {
    final payload = {
      'name': name,
      'gender': gender == 'ذكر' ? 'male' : 'female',
      'role': 'doctor',
      'specialization': specialty,
      'phone': phoneNumber,
      'image': imagePath,
      'password': password,
      'age': age,
      'email': email,
    };

    try {
      final response = await apiConsumer.post(
        BackendEndpoint.signUp,
        data: payload,
        isFromData: true,
      );

      // قم بتحويل الـ JSON إلى UserModel
      final userModelData = UserModel.fromJson(response['data']);
      await saveUserData(userModelData);

      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: 'حدث خطاء ما، حاول مرة اخرى'));
    }
  }

  Future<void> saveUserData(UserModel userModelData) async {
    var userData = jsonEncode(userModelData.toJson());

    await CacheHelper.saveData(key: kSaveUserDataKey, value: userData);
  }

  @override
  Future<Either<Failure, void>> logIn(
      {required String email, required String password}) async {
    try {
      final Map<String, dynamic> response = await apiConsumer.post(
        BackendEndpoint.logIn,
        data: {
          'email': email,
          'password': password,
        },
      );
      final userModelData = UserModel.fromJson(response['data']);
      await saveUserData(userModelData);
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: 'حدث خطاء ما، حاول مرة اخرى'));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword({required String email}) async {
    try {
      await apiConsumer
          .post(BackendEndpoint.forgetPassword, data: {'email': email});
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      {required String otp, required String newPassword}) async {
    try {
      await apiConsumer.post(BackendEndpoint.resetPassword, data: {
        'otp': otp,
        'password': newPassword,
      });
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(
      {required String email, required String otp}) async {
    try {
      await apiConsumer.post(BackendEndpoint.verifyOtp, data: {
        'email': email,
        'otp': otp,
      });
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    }
  }
}
