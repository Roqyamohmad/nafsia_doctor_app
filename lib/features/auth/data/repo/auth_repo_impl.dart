import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nafsia_app/core/errors/custom_exceptions.dart';
import 'package:nafsia_app/core/errors/failures.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/core/services/api_consumer.dart' show ApiConsumer;
import 'package:nafsia_app/core/services/zego_service.dart';
import 'package:nafsia_app/core/utils/backend_endpoint.dart';
//import 'package:nafsia_app/features/auth/data/models/avater_model.dart';
import 'package:nafsia_app/features/auth/data/models/doctr_model.dart';
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
    required String description,
    required MultipartFile profileImage,
    required MultipartFile licenseImage,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'gender': gender == 'ذكر' ? 'male' : 'female',
      'role': 'doctor',
      'specialization': specialty,
      'phone': phoneNumber,
      'password': password,
      'age': age.toString(),
      'email': email,
      'description': description,
      'avatar': profileImage, // ✅ أضف صورة البروفايل
      'medicalLicense': licenseImage,
    });

    try {
      final response = await apiConsumer.post(
        BackendEndpoint.signUp,
        data: formData,
        isFromData: true,
      );

      print('RESPONSE DATA: $response');

      final userModelData = UserModel.fromJson(response); // ✅ هنا التعديل

      await saveUserData(userModelData);
      print('✅ TOKEN: ${userModelData.data?.token}');
      print('✅ USER ID: ${userModelData.data?.user?.id}');
      print('✅ USER NAME: ${userModelData.data?.user?.name}');

      await initializeZego(
        userModelData.data!.user!.id!,
        userModelData.data!.user!.name!,
      );
      return right(null);
    } on ServerException catch (e) {
      print('ServerException: ${e.errorModel.errorMessage}');
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      print('Unexpected Error: $e');
      return left(ServerFailure(message: 'حدث خطاء ما، حاول مرة اخرى'));
    }
  }

  Future<void> saveUserData(UserModel userModelData) async {
    var userData = jsonEncode(userModelData.toJson());

    await CacheHelper.saveData(key: kSaveUserDataKey, value: userData);
    if (userModelData.data?.token != null) {
      // ✅ هنا التعديل
      await CacheHelper.saveData(
        key: 'userToken',
        value: userModelData.data!.token,
      );
    }
  }

  @override
  Future<Either<Failure, void>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> response = await apiConsumer.post(
        BackendEndpoint.logIn,
        data: {
          'email': email,
          'password': password,
        },
      );
      print(response.runtimeType); // هل هي Map ولا Response؟

      final userModelData = UserModel.fromJson(response); // ✅ هنا التعديل
      await initializeZego(
        userModelData.data!.user!.id!,
        userModelData.data!.user!.name!,
      );
      print('👤 userID: $userModelData.data!.user!.id!');
      print('👤 userName: $userModelData.data!.user!.name!');

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
  Future<Either<Failure, void>> resetPassword({
    required String otp,
    required String newPassword,
  }) async {
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
  Future<Either<Failure, void>> verifyOtp({
    required String email,
    required String otp,
  }) async {
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

  @override
  Future<Either<Failure, void>> updateUserProfile({
    String? specialization,
    String? name,
    String? phone,
    int? age,
  }) async {
    try {
      var token = getUserData().data?.token;
      final response = await apiConsumer.patch(
        BackendEndpoint.updateUserProfile,
        data: {
          'name': name,
          'phone': phone,
          'age': age,
          'specialization': specialization,
        },
        isFromData: true,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // 1. Get the existing user data from cache
      final oldUserData = await CacheHelper.getData(key: kSaveUserDataKey);
      if (oldUserData == null) {
        return left(
            ServerFailure(message: 'لم يتم العثور على بيانات المستخدم'));
      }

      final oldUserModel = UserModel.fromJson(jsonDecode(oldUserData));

      final updatedJson = response['data'];

      var updatedUser = oldUserModel.data?.user?.copyWith(
        name: updatedJson['name'],
        phone: updatedJson['phone'],
        age: updatedJson['age'],
        doctorData: updatedJson['doctorData'] != null
            ? DoctorDataModel.fromJson(updatedJson['doctorData'])
            : null,
      );

// 3. Save the updated user
      await saveUserData(UserModel(
          data: Data(user: updatedUser, token: oldUserModel.data?.token)));

      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: 'حدث خطأ أثناء تحديث البيانات'));
    }
  }

  @override
  Future<Either<Failure, void>> changeUserPassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      var token = getUserData().data?.token;
      await apiConsumer.put(
        BackendEndpoint.changeUserPassword,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: 'حدث خطاء ما، حاول مرة اخرى'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      var token = getUserData().data?.token;
      await apiConsumer.post(BackendEndpoint.logout, headers: {
        'Authorization': 'Bearer $token',
      });
      await CacheHelper.removeData(key: kSaveUserDataKey);

      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: 'حدث خطاء ما، حاول مرة اخرى'));
    }
  }
}
