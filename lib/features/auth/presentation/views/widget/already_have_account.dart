import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: 'لديك حساب بالفعل؟ ',
        style: TextStyles.semiBold16.copyWith(color: const Color(0xff949D9E)),
      ),
      TextSpan(
        text: ' تسجيل الدخول',
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            Navigator.pop(context);
          },
        style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
      ),
    ]));
  }
}
