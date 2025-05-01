import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../model/post_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, PostModel>> addPosts({
    required String content,
    MultipartFile? image,
  });
}
