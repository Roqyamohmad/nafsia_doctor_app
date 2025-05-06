import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nafsia_app/core/errors/custom_exceptions.dart';
import 'package:nafsia_app/core/errors/failures.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/core/services/api_consumer.dart';
import 'package:nafsia_app/core/utils/backend_endpoint.dart';
import 'package:nafsia_app/features/Home/data/model/post_model.dart';
import 'home_repo.dart';

class HomeRepoImplementation extends HomeRepo {
  final ApiConsumer apiConsumer;

  HomeRepoImplementation(this.apiConsumer);

  @override
  Future<Either<Failure, PostModel>> addPosts({
    required String title,
    required String content,
    required MultipartFile image,
  }) async {
    try {
      final token = getUserData().data?.token;
      final payload = {
        'content': content,
        'image': image,
        'title': "لا يوجد",
      };

      final response = await apiConsumer.post(BackendEndpoint.addPost,
          data: payload,
          isFromData: true,
          headers: {'Authorization': 'Bearer $token'});
      print('Bearer $token');

      final postModel = PostModel.fromJson(response);
      return Right(postModel);
    } catch (e) {
      print("Error: $e");
      return Left(ServerFailure(message: 'حدث خطأ ما، حاول مرة أخرى'));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    try {
      final response = await apiConsumer.get(BackendEndpoint.getAllPosts);
      final List<dynamic> data = response['data'];
      return right(data.map((e) => PostModel.fromJson(e)).toList());
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: 'حدث خطاء ما، حاول مرة اخرى'));
    }
  }

  /*

  Future<Either<Failure, void>> reactPost(
      {required String postId, required String reaction}) async {
    try {
      final token = getUserData().data?.token;
      await apiConsumer.post(BackendEndpoint.reactPost, data: {
        'postId': postId,
        'reactType': reaction,
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      print(token);
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      print(e.toString());
      return left(ServerFailure(message: 'حدث خطاء ما، حاول مرة اخرى'));
    }
  }

  @override
  Future<Either<Failure, int>> getPostReactions(
      {required String postId}) async {
    try {
      final response = await apiConsumer.get(
        BackendEndpoint.getPostReactions,
        data: {
          'postId': postId,
        },
      );

      final data = response['data'];

      if (data is List) {
        // Count only 'like' reactions if needed
        final likeCount =
            data.where((item) => item['reactType'] == 'like').length;
        return right(likeCount);
      } else {
        return right(0); // default if response isn't a list
      }
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      print(e.toString());
      return left(ServerFailure(message: 'حدث خطأ ما، حاول مرة أخرى'));
    }
  }

  @override
  Future<Either<Failure, void>> removeReaction({required String postId}) async {
    try {
      final token = getUserData().data?.token;
      await apiConsumer.delete(
        BackendEndpoint.reactPost,
        data: {'postId': postId},
        headers: {'Authorization': 'Bearer $token'},
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      print(e.toString());
      return left(ServerFailure(message: 'حدث خطأ ما، حاول مرة أخرى'));
    }
  }

  @override
  Future<Either<Failure, void>> savePost({required String postId}) async {
    try {
      final token = getUserData().data?.token;
      await apiConsumer.post(
        BackendEndpoint.savePost,
        data: {
          'postId': postId,
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      print(e.toString());
      return left(ServerFailure(message: 'حدث خطاء ما، حاول مرة اخرى'));
    }
  }
*/
  @override
  Future<Either<Failure, void>> deletePost({required String postId}) async {
    try {
      final token = getUserData().data?.token;
      await apiConsumer.delete(
        BackendEndpoint.deletePost(postId), // مثال: /posts/{postId}
        headers: {'Authorization': 'Bearer $token'},
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.errorModel.errorMessage));
    } catch (e) {
      print(e.toString());
      return left(ServerFailure(message: 'حدث خطأ ما، حاول مرة أخرى'));
    }
  }

  @override
  Future<Either<Failure, PostModel>> updatePost({
    required String postId,
    required String content,
    MultipartFile? image,
    required String title,
  }) async {
    try {
      final token = getUserData().data?.token;
      final Map<String, dynamic> payload = {
        'postId': postId,
        'content': content,
        'title': title,
      };

      if (image != null) {
        payload['image'] = image;
      }

      final response = await apiConsumer.patch(
        BackendEndpoint.updatePost(postId),
        data: payload,
        isFromData: true,
        headers: {'Authorization': 'Bearer $token'},
      );

      final postModel = PostModel.fromJson(response);
      return Right(postModel);
    } catch (e) {
      return Left(ServerFailure(message: 'حدث خطأ ما، حاول مرة أخرى'));
    }
  }
}
