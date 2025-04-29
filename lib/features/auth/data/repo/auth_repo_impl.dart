import 'package:dartz/dartz.dart';
import 'package:nafsia_app/core/errors/custom_exceptions.dart';
import 'package:nafsia_app/core/errors/failures.dart';
import 'package:nafsia_app/core/services/data_service.dart';
import 'package:nafsia_app/core/utils/backend_endpoint.dart';
import 'package:nafsia_app/features/auth/data/models/user_model.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final DatabaseService databaseService;

  AuthRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword({
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
      final response = await databaseService.addData(
        path: BackendEndpoint.addUserData,
        data: payload,
      );

      // قم بتحويل الـ JSON إلى UserModel
      final user = UserModel.fromJson(response);
      return right(user);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}
