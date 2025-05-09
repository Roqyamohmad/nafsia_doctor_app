import 'package:nafsia_app/features/Home/data/model/post_model.dart';

abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostSuccess extends AddPostState {
  final PostModel post;

  AddPostSuccess(this.post);
}

class AddPostFailure extends AddPostState {
  final String error;

  AddPostFailure(this.error);
}

// لحالة تعديل منشور
class UpdatePostLoading extends AddPostState {}

class UpdatePostSuccess extends AddPostState {
  final PostModel updatedPost;
  UpdatePostSuccess(this.updatedPost);
}

class UpdatePostFailure extends AddPostState {
  final String error;
  UpdatePostFailure(this.error);
}
