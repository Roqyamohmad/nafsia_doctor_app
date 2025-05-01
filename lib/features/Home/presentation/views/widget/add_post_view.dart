import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/add_post_cubit/add_post_state.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_main_view_app_bar.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/image_field.dart';

import '../../cubits/add_post_cubit/add_Post_cubit.dart';

//import '../../../../auth/presentation/views/widget/image_field.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final TextEditingController postController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddPostCubit>(),
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const CustomMainViewsAppBar(
                    title: 'اضافة منشور',
                    showBack: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ما الذي يدور في ذهنك؟',
                        textAlign: TextAlign.start,
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
                        labelText: '', // نخليه فاضي عشان ما يتكرر
                        textInputType: TextInputType.multiline,
                        controller: postController,
                        showAsterisk: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ImageFormField(
                    initialValue: image,
                    validator: (file) {
                      if (file == null) return 'يرجى رفع الصورة';
                      return null;
                    },
                    onSaved: (file) {
                      image = file;
                    },
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<AddPostCubit, AddPostState>(
                    listener: (context, state) {
                      if (state is AddPostSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم نشر البوست بنجاح')),
                        );
                        Navigator.pop(context);
                      } else if (state is AddPostFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: state is AddPostLoading
                            ? null
                            : () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _formKey.currentState
                                      ?.save(); // دي مهمة جدا عشان onSaved تشتغل

                                  if (postController.text.trim().isNotEmpty &&
                                      image != null) {
                                    // حوّلي File لـ MultipartFile هنا
                                    final multipartImage =
                                        await MultipartFile.fromFile(
                                      image!.path,
                                      filename: image!.path.split('/').last,
                                    );

                                    BlocProvider.of<AddPostCubit>(context)
                                        .addPost(
                                      content: postController.text.trim(),
                                      image: multipartImage,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'يرجى كتابة المنشور ورفع الصورة')),
                                    );
                                  }
                                }
                              },
                        label: state is AddPostLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'نشر',
                                style: TextStyle(color: Colors.white),
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
