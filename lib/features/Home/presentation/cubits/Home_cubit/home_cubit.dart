import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/features/Home/data/model/post_model.dart';

import '../../../data/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitialState());

  final HomeRepo homeRepo;

  /// يخزن ما إذا كان المستخدم قد أعجب بكل بوست
  //Map<String, String> isLiked = {};

  /// يخزن عدد الإعجابات لكل بوست
  // Map<String, int> postReactions = {};

  /// قائمة البوستات الحالية في الواجهة
  List<PostModel> posts = [];

  /// جلب جميع البوستات وتخزينها محليًا
  Future<void> getAllPosts() async {
    emit(GetAllPostsLoadingState());
    final result = await homeRepo.getPosts();

    result.fold(
      (failure) {
        emit(GetAllPostsFailureState(errorMessage: failure.message));
      },
      (fetchedPosts) {
        // خزنهم في الخاصية المحلية
        posts = fetchedPosts;

        // final String? currentUserId = getUserData().data?.user?.id;
        //isLiked.clear();
        //postReactions.clear();

        //for (var post in posts) {
        //final id = post.id;
        // عدد الإعجابات
        // postReactions[id] =
        // post.reactions.where((r) => r.type == 'like').length;
        // هل أعجب المستخدم الحالي؟
        /*
          isLiked[id] = post.reactions.any((r) => r.user.id == currentUserId)
              ? 'like'
              : '';
              */
        //}

        emit(GetAllPostsSuccessState(posts: List.from(posts)));
      },
    );
  }

/*
  /// إضافة/إزالة لايك
  Future<void> reactPost({
    required String postId,
    required String reaction,
  }) async {
    final alreadyLiked = isLiked[postId] == reaction;
    final result = alreadyLiked
        ? await homeRepo.removeReaction(postId: postId)
        : await homeRepo.reactPost(postId: postId, reaction: reaction);

    result.fold(
      (failure) {
        emit(ReactPostFailureState(errorMessage: failure.message));
      },
      (_) async {
        // حدّث الحالة المحلية
        if (alreadyLiked) {
          isLiked[postId] = '';
          postReactions[postId] = (postReactions[postId] ?? 1) - 1;
        } else {
          isLiked[postId] = reaction;
          postReactions[postId] = (postReactions[postId] ?? 0) + 1;
        }
        emit(ReactPostSuccessState());
      },
    );
  }

  /// حفظ المنشور
  Future<void> savePost({required String postId}) async {
    final result = await homeRepo.savePost(postId: postId);
    result.fold(
      (failure) {
        emit(SavePostFailureState(errorMessage: failure.message));
      },
      (_) {
        emit(SavePostSuccessState());
      },
    );
  }
*/
  /// حذف المنشور
  /// حذف المنشور
  Future<void> deletePost({required String postId}) async {
    emit(DeletePostLoadingState());
    final result = await homeRepo.deletePost(postId: postId);

    result.fold(
      (failure) {
        // ✅ لو السيرفر قال إن المنشور مش موجود، نمسحه محليًا كأنه اتحذف
        if (failure.message.contains("غير موجود")) {
          posts.removeWhere((post) => post.id == postId);
          emit(DeletePostSuccessState());
          emit(GetAllPostsSuccessState(posts: List.from(posts)));
        } else {
          // ❌ مشكلة تانية فعلاً حصلت
          emit(DeletePostFailureState(failure.message));
        }
      },
      (_) async {
        // ✅ حذف ناجح
        posts.removeWhere((post) => post.id == postId);
        emit(DeletePostSuccessState());
        emit(GetAllPostsSuccessState(posts: List.from(posts)));

        // ✅ (اختياري) تحدث البوستات من السيرفر لو حابب تضمن أحدث نسخة
        await getAllPosts();
      },
    );
  }
}
