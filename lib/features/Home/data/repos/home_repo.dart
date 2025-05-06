import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../model/post_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, PostModel>> addPosts({
    required String title,
    required String content,
    required MultipartFile image,
  });
  Future<Either<Failure, List<PostModel>>> getPosts();
  /*Future<Either<Failure, void>> reactPost(
      {required String postId, required String reaction});
  Future<Either<Failure, int>> getPostReactions({required String postId});
  Future<Either<Failure, void>> removeReaction({required String postId});
  Future<Either<Failure, void>> savePost({required String postId});
  */
  Future<Either<Failure, void>> deletePost({required String postId});
  Future<Either<Failure, PostModel>> updatePost({
    MultipartFile? image,
    required String postId,
    required String title,
    required String content,
  });
}
