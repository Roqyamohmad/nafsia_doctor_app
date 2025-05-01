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
