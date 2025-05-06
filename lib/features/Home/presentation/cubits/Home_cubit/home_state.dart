import '../../../data/model/post_model.dart';

abstract class HomeState {}

final class HomeInitialState extends HomeState {}

final class GetAllPostsLoadingState extends HomeState {}

final class GetAllPostsSuccessState extends HomeState {
  final List<PostModel> posts;
  GetAllPostsSuccessState({required this.posts});
}

final class GetAllPostsFailureState extends HomeState {
  final String errorMessage;
  GetAllPostsFailureState({required this.errorMessage});
}

final class ReactPostSuccessState extends HomeState {}

final class ReactPostFailureState extends HomeState {
  final String errorMessage;
  ReactPostFailureState({required this.errorMessage});
}

final class GetPostReactionsSuccessState extends HomeState {}

final class SavePostFailureState extends HomeState {
  final String errorMessage;
  SavePostFailureState({required this.errorMessage});
}

final class SavePostSuccessState extends HomeState {}

// لحذف المنشور
class DeletePostLoadingState extends HomeState {}

class DeletePostSuccessState extends HomeState {}

class DeletePostFailureState extends HomeState {
  final String message;
  DeletePostFailureState(this.message);
}
