import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart'
    show CustomTextFormField;
import 'package:nafsia_app/features/Home/presentation/views/widget/custom_main_view_app_bar.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameController = TextEditingController(text: 'د. أحمد علي');
  final emailController = TextEditingController(text: 'ahmed.ali@email.com');
  final phoneController = TextEditingController(text: '+966 512345678');
  final jobController = TextEditingController(text: 'أخصائي نفسي');
  final addressController = TextEditingController(text: 'الرياض - السعودية');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const CustomMainViewsAppBar(
                      title: 'تعديل الملف الشخصي', showBack: true),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    labelText: 'الاسم',
                    textInputType: TextInputType.name,
                    controller: nameController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'البريد الإلكتروني',
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'رقم الجوال',
                    textInputType: TextInputType.phone,
                    controller: phoneController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'الوظيفة',
                    textInputType: TextInputType.text,
                    controller: jobController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'العنوان',
                    textInputType: TextInputType.text,
                    controller: addressController,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // عملية الحفظ
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('تم حفظ التعديلات بنجاح')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'حفظ التعديلات',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    jobController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
