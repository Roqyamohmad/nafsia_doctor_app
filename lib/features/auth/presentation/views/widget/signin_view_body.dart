import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_button.dart' show CustomButton;
import 'package:nafsia_app/core/widgets/custom_text_field.dart'
    show CustomTextFormField;
import 'package:nafsia_app/core/widgets/password_field.dart';
import 'package:nafsia_app/features/auth/presentation/views/forget_password_view.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/dont_have_account.dart'
    show DontHaveAnAccount;
import 'package:nafsia_app/features/auth/presentation/views/widget/login_view_body_logo_and_title.dart';

import '../../../../../core/utils/app_text_styles.dart';
import '../../cubits/signin_cubits/signin_cubit.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;
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
              const LoginViewBodyLogoAndTitle(
                title: 'مرحبًا بكم في نفسية',
              ),
              verticalSpace(20),
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
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ForgetPasswordView.route);
                  },
                  child: Text(
                    'نسيت كلمة المرور ؟ ',
                    style: TextStyles.bold16
                        .copyWith(color: AppColors.secondaryColor),
                  ),
                ),
              ),
              verticalSpace(16),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    context
                        .read<SigninCubit>()
                        .logIn(email: email, password: password);
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                text: 'تسجيل دخول',
              ),
              verticalSpace(16),
              const DontHaveAnAccount(),
              verticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }
}
