import 'package:dartz/dartz.dart';
import 'package:nafsia_app/features/auth/data/models/user_model.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required int age,
    required String gender,
    required String phoneNumber,
    required String specialty,
    //required String medicalLicenseNumber,
   // required String licensingAuthority,
    required String? imagePath,
  });
}
