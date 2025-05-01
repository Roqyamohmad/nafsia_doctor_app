import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nafsia_app/core/errors/failures.dart';
import 'package:nafsia_app/core/services/api_consumer.dart';
import 'package:nafsia_app/core/utils/backend_endpoint.dart';
import 'package:nafsia_app/features/Home/data/model/post_model.dart';
import 'home_repo.dart';

class HomeRepoImplementation extends HomeRepo {
  final ApiConsumer apiConsumer;

  HomeRepoImplementation(this.apiConsumer);

  @override
  Future<Either<Failure, PostModel>> addPosts({
    required String content,
    MultipartFile? image,
  }) async {
    try {
      final payload = {'content': content, 'image': image};

      final response = await apiConsumer.post(
        BackendEndpoint.addPost,
        data: payload,
        isFromData: true,
      );

      final postModel = PostModel.fromJson(response);
      return Right(postModel);
    } catch (e) {
      print("Error: $e");
      return Left(ServerFailure(message: 'حدث خطأ ما، حاول مرة أخرى'));
    }
  }
}
