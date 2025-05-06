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
    required MultipartFile image,
    required String title,
  }) async {
    emit(AddPostLoading());
    final result =
        await homeRepo.addPosts(content: content, image: image, title: title);

    result.fold(
      (failure) {
        emit(AddPostFailure(failure.message));
      },
      (post) {
        emit(AddPostSuccess(post));
      },
    );
  }

  Future<void> updatePost({
    required String postId,
    required String content,
    required MultipartFile?
        image, // نخليه nullable لو حبيت تخلي الصورة اختيارية وقت التعديل
    required String title,
  }) async {
    emit(UpdatePostLoading());

    final result = await homeRepo.updatePost(
      postId: postId,
      content: content,
      image: image,
      title: title,
    );

    result.fold(
      (failure) {
        emit(UpdatePostFailure(failure.message));
      },
      (post) {
        emit(UpdatePostSuccess(post));
      },
    );
  }
}
