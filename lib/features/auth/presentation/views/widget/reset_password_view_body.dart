import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/helper_functions/app_regex.dart';
import 'package:nafsia_app/core/helper_functions/build_error_bar.dart';
import 'package:nafsia_app/core/utils/app_text_styles.dart';
import 'package:nafsia_app/core/utils/constants.dart';
import 'package:nafsia_app/core/widgets/custom_animated_loading_widget.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/forget_password_cubit/forget_password_state.dart';
import 'package:nafsia_app/features/auth/presentation/views/signin_view.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({
    super.key,
    required this.otp,
  });

  final String otp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 50, horizontal: kHorizontalPadding),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            showBar(context, 'تم تغيير كلمة المرور بنجاح');
            Navigator.pushNamed(
                context, SigninView.routeName); // or your login route
          } else if (state is ResetPasswordFailureState) {
            showBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          final cubit = context.read<ForgetPasswordCubit>();
          return Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ادخل كلمة مرور جديدة لحسابك',
                  style: TextStyles.semiBold16,
                ),
                verticalSpace(8),
                CustomTextFormField(
                  controller: cubit.newPasswordController,
                  labelText: 'كلمة المرور الجديدة',
                  needsValidation: true,
                  validator: (value) {
                    if (value!.isEmpty || !AppRegex.isPasswordValid(value)) {
                      return 'كلمة المرور ضعيفة';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    cubit.newPasswordController.text = value;
                  },
                  textInputType: TextInputType.text,
                ),
                verticalSpace(16),
                CustomTextFormField(
                  controller: cubit.confirmNewPasswordController,
                  labelText: 'تأكيد كلمة المرور',
                  needsValidation: true,
                  validator: (value) {
                    if (value != cubit.newPasswordController.text) {
                      return 'كلمتا المرور غير متطابقتين';
                    }
                    return null;
                  },
                  textInputType: TextInputType.emailAddress,
                ),
                verticalSpace(24),
                state is ResetPasswordLoadingState
                    ? const Center(child: CustomAnimatedLoadingWidget())
                    : CustomButton(
                        text: 'إعادة تعيين كلمة المرور',
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            BlocProvider.of<ForgetPasswordCubit>(context)
                                .resetPassword(
                              otp: otp,
                            );
                          }
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
