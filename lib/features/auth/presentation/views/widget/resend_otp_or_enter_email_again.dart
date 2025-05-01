import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart' show TextStyles;
import 'package:nafsia_app/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/forget_password_cubit/forget_password_state.dart';

import '../../../../../core/utils/app_colors.dart';

class ResendOtpOrEnterEmailAgain extends StatelessWidget {
  const ResendOtpOrEnterEmailAgain({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('لم يصلك الرمز؟', style: TextStyles.semiBold16),
        BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
          builder: (context, state) {
            final cubit = context.read<ForgetPasswordCubit>();
            final canResend = cubit.canResend;
            final remaining = cubit.remainingSeconds;

            return TextButton(
              onPressed: canResend
                  ? () {
                      cubit.sendResetCode(email: email);
                    }
                  : null,
              child: Text(
                canResend ? 'إعادة ارسال الرمز' : 'انتظر $remaining ثانية',
                style: TextStyles.bold16.copyWith(
                  color: canResend ? AppColors.primaryColor : Colors.grey,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
