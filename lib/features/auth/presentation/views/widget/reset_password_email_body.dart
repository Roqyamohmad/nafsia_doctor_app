import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;
import 'package:nafsia_app/core/widgets/custom_button.dart' show CustomButton;
import 'package:nafsia_app/core/widgets/custom_text_field.dart';

import 'forget_password.dart';

class ResetPasswordEmailBody extends StatelessWidget {
  const ResetPasswordEmailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ForgetPassword(
            title: ' أدخل بريدك الإلكتروني لتلقي رمز إعادة التعيين',
          ),
          verticalSpace(16),
          CustomTextFormField(
            textInputType: TextInputType.emailAddress,
            labelText: 'البريد الإلكتروني',
          ),
          verticalSpace(16),
          const CustomButton(text: ' اسنمر'),
        ],
      ),
    );
  }
}
