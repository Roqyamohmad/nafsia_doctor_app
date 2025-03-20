import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';

import 'widget/reset_password_email_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});
  static const routeName = 'resetPassword';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backGroundyColor,
      body: SafeArea(
        child: ResetPasswordEmailBody(),
      ),
    );
  }
}
