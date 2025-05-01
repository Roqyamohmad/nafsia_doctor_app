import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/helper_functions/build_error_bar.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/widgets/custom_animated_loading_widget.dart';
import 'package:nafsia_app/core/widgets/custom_button.dart';
import 'package:nafsia_app/core/widgets/custom_text_field.dart';
import 'package:nafsia_app/features/auth/presentation/views/Verify_otp_view.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/spacing.dart';
import '../../cubits/forget_password_cubit/forget_password_cubit.dart';
import '../../cubits/forget_password_cubit/forget_password_state.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordFailureState) {
          showBar(context, state.errorMessage);
        } else if (state is ForgetPasswordSuccessState) {
          showBar(context, 'تم ارسال البريد الالكتروني بنجاح');
          Navigator.pushNamed(context, VerifyOtpView.route,
              arguments:
                  context.read<ForgetPasswordCubit>().emailController.text);
        }
      },
      builder: (context, state) {
        final cubit = context.watch<ForgetPasswordCubit>();

        return Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 50, horizontal: kHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'من فضلك قم بادخال بريدك الالكتروني للإعادة تعيين كلمة المرور',
                  style: TextStyles.semiBold16,
                ),
                verticalSpace(8),
                CustomTextFormField(
                  labelText: 'البريد الالكتروني',
                  needsValidation: true,
                  textInputType: TextInputType.emailAddress,
                  controller: cubit.emailController,
                  onChanged: (value) {
                    cubit.emailController.text = value;
                  },
                ),
                verticalSpace(24),
                verticalSpace(8),
                state is ForgetPasswordLoadingState
                    ? const Center(child: CustomAnimatedLoadingWidget())
                    : CustomButton(
                        backgroundColor: cubit.canResend
                            ? AppColors.primaryColor
                            : Colors.grey,
                        text: cubit.canResend
                            ? 'ارسال البريد الالكتروني'
                            : 'يمكنك إعادة الإرسال بعد ${cubit.remainingSeconds} ثانية',
                        onPressed: cubit.canResend
                            ? () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.sendResetCode(
                                    email: cubit.emailController.text,
                                  );
                                }
                              }
                            : null, // Disable the button if timer is running
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
