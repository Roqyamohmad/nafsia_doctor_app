import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/helper_functions/app_regex.dart';
import 'package:nafsia_app/core/helper_functions/build_error_bar.dart'
    show showBar;
import 'package:nafsia_app/core/helper_functions/detect_mime_type.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_button.dart';
import 'package:nafsia_app/core/widgets/password_field.dart';
//import 'package:nafsia_app/features/auth/data/models/avater_model.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/index.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../../core/widgets/custom_drop_down_form_field.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? selectedGender;
  File? avatarImage;
  File? licenseImage;

  bool isTermsAccepted = false;

  late String name, email, password, phoneNumber, specialty, description;
  late int age;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const LoginViewBodyLogoAndTitle(title: 'انضم إلينا'),
              verticalSpace(20),
              CustomTextFormField(
                textInputType: TextInputType.text,
                labelText: 'الاسم بالكامل',
                onSaved: (value) => name = value!,
              ),
              verticalSpace(16),
              CustomTextFormField(
                textInputType: TextInputType.number,
                labelText: 'العمر',
                onSaved: (value) => age = int.parse(value!),
              ),
              verticalSpace(16),
              CustomDropdownFormField(
                hintText: 'الجنس',
                needsValidation: true,
                items: const ['ذكر', 'أنثى'],
                value: selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
              ),
              verticalSpace(16),
              CustomTextFormField(
                textInputType: TextInputType.phone,
                labelText: 'رقم الهاتف',
                onSaved: (value) => phoneNumber = value!,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isPhoneNumberValid(value)) {
                    return 'برجاء ادخال رقم هاتف صالح';
                  }
                  return null;
                },
              ),
              verticalSpace(16),
              CustomTextFormField(
                textInputType: TextInputType.text,
                labelText: 'التخصص الطبي',
                onSaved: (value) => specialty = value!,
              ),
              verticalSpace(16),
              CustomTextFormField(
                textInputType: TextInputType.text,
                labelText: 'الوصف الطبي',
                onSaved: (value) => description = value!,
              ),
              verticalSpace(16),
              CustomTextFormField(
                textInputType: TextInputType.emailAddress,
                labelText: 'البريد الإلكتروني',
                onSaved: (value) => email = value!,
              ),
              verticalSpace(16),
              PasswordField(
                onSaved: (value) => password = value!,
              ),
              verticalSpace(16),
              // صورة البروفايل
              Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'صورة البروفايل',
                      style: TextStyles.bold16.copyWith(color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 8),
                    ImageFormField(
                      initialValue: avatarImage,
                      validator: (file) {
                        if (file == null) return 'يرجى رفع صورة البروفايل';
                        return null;
                      },
                      onSaved: (file) {
                        avatarImage = file;
                      },
                    ),
                  ],
                ),
              ),
              verticalSpace(16),
              // صورة الرخصة الطبية
              Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'صورة الرخصة الطبية',
                      style: TextStyles.bold16.copyWith(color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 8),
                    ImageFormField(
                      initialValue: licenseImage,
                      validator: (file) {
                        if (file == null) return 'يرجى رفع صورة الترخيص';
                        return null;
                      },
                      onSaved: (file) {
                        licenseImage = file;
                      },
                    ),
                  ],
                ),
              ),
              TermsAndConditions(
                onChanged: (value) {
                  isTermsAccepted = value;
                },
              ),
              verticalSpace(16),
              CustomButton(
                text: 'إنشاء حساب',
                onPressed: () async {
                  if (isTermsAccepted && selectedGender != null) {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      if (avatarImage != null && licenseImage != null) {
                        final profileImage = await MultipartFile.fromFile(
                          avatarImage!.path,
                          filename: avatarImage!.path.split('/').last,
                          contentType: MediaType(
                              'image', detectMimeType(avatarImage!.path)),
                        );

                        final licenseFile = await MultipartFile.fromFile(
                          licenseImage!.path,
                          filename: licenseImage!.path.split('/').last,
                          contentType: MediaType(
                              'image', detectMimeType(licenseImage!.path)),
                        );

                        context
                            .read<SignupCubit>()
                            .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                              name: name,
                              age: age,
                              gender: selectedGender!,
                              phoneNumber: phoneNumber,
                              specialty: specialty,
                              profileImage: profileImage,
                              licenseImage: licenseFile,
                              description: description,
                            );
                      } else {
                        showBar(context, 'برجاء رفع صور البروفايل والترخيص');
                      }
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  } else {
                    if (!isTermsAccepted) {
                      showBar(context, 'برجاء الموافقة على الشروط ');
                    }
                  }
                },
              ),
              verticalSpace(16),
              const AlreadyHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
