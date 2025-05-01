import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/helper_functions/build_error_bar.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/constants.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_animated_loading_widget.dart';
import 'package:nafsia_app/core/widgets/custom_button.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/forget_password_cubit/forget_password_state.dart';
import 'package:nafsia_app/features/auth/presentation/views/reset_password_view.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/resend_otp_or_enter_email_again.dart';

import '../../../../../core/utils/app_colors.dart';

class VerifyOtpViewBody extends StatelessWidget {
  const VerifyOtpViewBody({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 50, horizontal: kHorizontalPadding),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is OtpVerificationSuccessState) {
            showBar(context, 'تم التحقق من الرمز بنجاح');

            Navigator.pushNamed(context, ResetPasswordView.routeName,
                arguments:
                    context.read<ForgetPasswordCubit>().otpController.text);
          } else if (state is OtpVerificationFailureState) {
            showBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return Form(
            key: context.read<ForgetPasswordCubit>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ادخل الرمز الذي تم إرساله إلى : $email  ',
                  style: TextStyles.semiBold16,
                ),
                verticalSpace(8),
                SizedBox(
                  width: 100.w,
                  child: CustomTextFormField(
                    controller:
                        context.read<ForgetPasswordCubit>().otpController,
                    labelText: 'رمز التحقق',
                    needsValidation: true,
                    textAlign: TextAlign.center,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك ادخل الرمز';
                      }
                      return null;
                    },
                  ),
                ),
                verticalSpace(24),
                state is OtpVerificationLoadingState
                    ? const Center(child: CustomAnimatedLoadingWidget())
                    : CustomButton(
                        text: 'تحقق',
                        onPressed: () {
                          if (context
                              .read<ForgetPasswordCubit>()
                              .formKey
                              .currentState!
                              .validate()) {
                            context
                                .read<ForgetPasswordCubit>()
                                .verifyOtp(email: email);
                          }
                        },
                      ),
                verticalSpace(4),
                ResendOtpOrEnterEmailAgain(email: email),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'إعادة ادخال البريد الالكتروني؟',
                      style: TextStyles.bold16
                          .copyWith(color: AppColors.primaryColor),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
