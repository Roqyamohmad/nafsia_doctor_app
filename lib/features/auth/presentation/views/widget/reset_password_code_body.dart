import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/spacing.dart' show verticalSpace;
import 'package:nafsia_app/core/widgets/custom_button.dart' show CustomButton;
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/resent_code.dart'
    show ResentCode;

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
            title: 'لقد أرسلنا بريدًا إلكترونيًا إلى y********@g****.com',
          ),
          verticalSpace(16),
          const CustomTextFormField(
            textInputType: TextInputType.emailAddress,
            labelText: 'ادخل الرمز',
          ),
          verticalSpace(16),
          const CustomButton(text: ' اسنمر'),
          verticalSpace(16),
          const ResentCode(),
        ],
      ),
    );
  }
}
