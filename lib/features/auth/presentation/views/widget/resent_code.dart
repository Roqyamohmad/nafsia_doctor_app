import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;
import 'package:nafsia_app/features/auth/presentation/views/signup_view.dart';

class ResentCode extends StatelessWidget {
  const ResentCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: 'لم تستلم الرمز؟ ',
        style: TextStyles.semiBold16.copyWith(
          color: const Color(
            0xff949D9E,
          ),
        ),
      ),
      TextSpan(
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            Navigator.pushNamed(context, SignupView.routeName);
          },
        text: 'قم بإعادةالارسال',
        style: TextStyles.bold16.copyWith(
          color: AppColors.primaryColor,
        ),
      ),
    ]));
  }
}
