import 'package:dartz/dartz.dart' show Either;
import 'package:nafsia_app/features/auth/domain/entites/user_entity.dart'
    show UserEntity;

import '../../../../core/errors/failures.dart';

abstract class AuthRebo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name);
}
