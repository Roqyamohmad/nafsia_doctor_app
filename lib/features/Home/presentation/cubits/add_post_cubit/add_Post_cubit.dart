// ignore_for_file: file_names

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:nafsia_app/features/Home/data/repos/home_repo.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/add_post_cubit/add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final HomeRepo homeRepo;

  AddPostCubit(this.homeRepo) : super(AddPostInitial());

  Future<void> addPost({
    required String content,
    MultipartFile? image,
  }) async {
    emit(AddPostLoading());
    final result = await homeRepo.addPosts(content: content, image: image);

    result.fold(
      (failure) {
        emit(AddPostFailure(failure.message));
      },
      (post) {
        emit(AddPostSuccess(post));
      },
    );
  }
}
