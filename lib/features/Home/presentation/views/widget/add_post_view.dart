import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_main_view_app_bar.dart';

//import '../../../../auth/presentation/views/widget/image_field.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final TextEditingController postController = TextEditingController();
  File? selectedImage;

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
              /*
              ImageField(
                onFileChanged: (file) {
                  setState(() {
                    selectedImage = file;
                  });
                },
              ),
              */
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  if (postController.text.trim().isNotEmpty) {
                    // هنا يمكنك لاحقًا حفظ المنشور في قاعدة البيانات مع selectedImage
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم نشر البوست بنجاح')),
                    );
                    Navigator.pop(context);
                  }
                },
                label: const Text(
                  'نشر',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
