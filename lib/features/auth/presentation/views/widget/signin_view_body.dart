import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_images.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_button.dart' show CustomButton;
import 'package:nafsia_app/core/widgets/custom_text_field.dart'
    show CustomTextFormField;
import 'package:nafsia_app/core/widgets/password_field.dart';
import 'package:nafsia_app/features/Home/presentation/views/main_view.dart';
import 'package:nafsia_app/features/auth/presentation/views/reset_password_view.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/dont_have_account.dart'
    show DontHaveAnAccount;
import 'package:nafsia_app/features/auth/presentation/views/widget/login_view_body_logo_and_title.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/or_divider.dart'
    show OrDivider;
import 'package:nafsia_app/features/auth/presentation/views/widget/social_login_button.dart';

import '../../../../../core/utils/app_text_styles.dart';

class SigninViewBody extends StatelessWidget {
  const SigninViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const LoginViewBodyLogoAndTitle(
              title: 'مرحبًا بكم في نفسية',
            ),
            verticalSpace(20),
            const CustomTextFormField(
              textInputType: TextInputType.emailAddress,
              labelText: 'البريد الإلكتروني',
            ),
            verticalSpace(16),
            const PasswordField(),
            verticalSpace(16),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ResetPasswordView.routeName);
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
              text: 'تسجيل الدخول',
              onPressed: () {
                Navigator.pushNamed(context, MainView.routeName);
              },
            ),
            verticalSpace(16),
            const DontHaveAnAccount(),
            verticalSpace(30),
            const OrDivider(),
            verticalSpace(60),
            SocialLoginButton(
              image: Assets.assetsImagesGoogleIcon,
              title: 'تسجيل الدخول بواسطة جوجل',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
