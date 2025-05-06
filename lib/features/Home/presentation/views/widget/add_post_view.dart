import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart' show getIt;
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/Home/data/model/post_model.dart';
import 'package:nafsia_app/features/Home/data/repos/home_repo.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/add_post_cubit/add_post_state.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/image_field.dart';
import '../../cubits/add_post_cubit/add_Post_cubit.dart';
import '../../cubits/home_cubit/home_cubit.dart';

class AddPostView extends StatefulWidget {
  final PostModel? existingPost;
  final HomeCubit homeCubit;

  const AddPostView({Key? key, this.existingPost, required this.homeCubit})
      : super(key: key);

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final TextEditingController postController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;

  @override
  void initState() {
    super.initState();
    if (widget.existingPost != null) {
      postController.text = widget.existingPost!.content;
    }
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddPostCubit(getIt<HomeRepo>()), // Providing the AddPostCubit here
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.existingPost != null ? 'تعديل المنشور' : 'إضافة منشور',
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Text(
                    'ما الذي يدور في ذهنك؟',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff949D9E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    minLines: 9,
                    maxLines: 9,
                    labelText: '',
                    textInputType: TextInputType.multiline,
                    controller: postController,
                    showAsterisk: false,
                  ),
                  const SizedBox(height: 16),
                  ImageFormField(
                    initialValue: image,
                    validator: (file) {
                      if (widget.existingPost == null && file == null) {
                        return 'يرجى رفع الصورة';
                      }
                      return null;
                    },
                    onSaved: (file) => image = file,
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<AddPostCubit, AddPostState>(
                    listener: (context, state) {
                      if (state is AddPostSuccess ||
                          state is UpdatePostSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state is AddPostSuccess
                                  ? 'تم النشر بنجاح'
                                  : 'تم التحديث بنجاح',
                            ),
                          ),
                        );
                        widget.homeCubit.getAllPosts();
                        Navigator.pop(context);
                      } else if (state is AddPostFailure ||
                          state is UpdatePostFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.toString())),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: state is AddPostLoading ||
                                state is UpdatePostLoading
                            ? null
                            : () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _formKey.currentState?.save();
                                  if (postController.text.trim().isNotEmpty) {
                                    MultipartFile? multipartImage;
                                    if (image != null) {
                                      final mimeType =
                                          lookupMimeType(image!.path);
                                      multipartImage =
                                          await MultipartFile.fromFile(
                                        image!.path,
                                        filename: image!.path.split('/').last,
                                        contentType: MediaType.parse(
                                            mimeType ?? 'image/jpeg'),
                                      );
                                    }

                                    if (widget.existingPost != null) {
                                      BlocProvider.of<AddPostCubit>(context)
                                          .updatePost(
                                        postId: widget.existingPost!.id,
                                        content: postController.text.trim(),
                                        image: multipartImage,
                                        title: 'لا يوجد',
                                      );
                                    } else {
                                      if (multipartImage == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('يرجى رفع صورة')),
                                        );
                                        return;
                                      }
                                      BlocProvider.of<AddPostCubit>(context)
                                          .addPost(
                                        title: "لا يوجد",
                                        content: postController.text.trim(),
                                        image: multipartImage,
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('يرجى كتابة المنشور')),
                                    );
                                  }
                                }
                              },
                        label: state is AddPostLoading ||
                                state is UpdatePostLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                widget.existingPost != null ? 'تحديث' : 'نشر',
                                style: const TextStyle(color: Colors.white),
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
