import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;
import 'package:nafsia_app/core/widgets/custom_button.dart' show CustomButton;
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/core/widgets/password_field.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/already_have_account.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/login_view_body_logo_and_title.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/terms_and_conditions.dart'
    show TermsAndConditions;
import '../../../../../core/helper_functions/app_regex.dart';
import '../../../../../core/widgets/custom_drop_down_form_field.dart';
import 'image_field.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  String? selectedGender;
  late bool isTermsAccepted = false;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const LoginViewBodyLogoAndTitle(
              title: 'انضم إلينا',
            ),
            verticalSpace(20),
            CustomTextFormField(
              textInputType: TextInputType.text,
              labelText: 'الاسم الاول',
            ),
            verticalSpace(16),
            CustomTextFormField(
              textInputType: TextInputType.text,
              labelText: 'الاسم الثاني',
            ),
            verticalSpace(16),
            CustomTextFormField(
                textInputType: TextInputType.number, labelText: 'العمر'),
            verticalSpace(16),
            CustomDropdownFormField(
              hintText: 'الجنس',
              needsValidation: true,
              items: ['ذكر', 'أنثى'],
              value: selectedGender, // Pass the selected value
              onChanged: (newValue) {
                setState(() {
                  selectedGender = newValue; // Update the value
                });
              },
            ),
            verticalSpace(16),
            CustomTextFormField(
              textInputType: TextInputType.phone,
              labelText: 'رقم الهاتف',
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
            ),
            verticalSpace(16),
            CustomTextFormField(
              textInputType: TextInputType.number,
              labelText: 'رقم الترخيص الطبي',
            ),
            verticalSpace(16),
            CustomTextFormField(
              textInputType: TextInputType.text,
              labelText: 'الجهة المانحه للترخيص',
            ),
            verticalSpace(16),
            CustomTextFormField(
              textInputType: TextInputType.emailAddress,
              labelText: 'البريد الإلكتروني',
            ),
            verticalSpace(16),
            const PasswordField(),
            verticalSpace(16),
            ImageField(
              onFileChanged: (image) {
                this.image = image;
              },
            ),
            TermsAndConditions(
              onChanged: (value) {
                isTermsAccepted = value;
              },
            ),
            verticalSpace(16),
            const CustomButton(
              text: 'إنشاء حساب',
            ),
            verticalSpace(16),
            const AlreadyHaveAccount(),
          ],
        ),
      ),
    );
  }
}
