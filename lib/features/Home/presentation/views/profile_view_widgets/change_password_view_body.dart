import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafsia_app/core/helper_functions/build_error_bar.dart';
import 'package:nafsia_app/core/helper_functions/custom_quick_alret_view.dart';
import 'package:nafsia_app/core/utils/spacing.dart';
import 'package:nafsia_app/core/widgets/custom_animated_loading_widget.dart';
import 'package:nafsia_app/core/widgets/custom_button.dart';
import 'package:nafsia_app/core/widgets/password_field.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/more_cubit/more_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/more_cubit/more_state.dart';
import 'package:nafsia_app/features/Home/presentation/views/main_view.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../../../../core/utils/constants.dart';

class ChangePasswordViewBody extends StatelessWidget {
  const ChangePasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MoreCubit>();
    return BlocConsumer<MoreCubit, MoreState>(
      listener: (context, state) {
        if (state is ChangeUserPasswordSuccessState) {
          customQuickAlertView(context,
              text: 'تم تغيير كلمة المرور بنجاح',
              title: 'تمت العملية بنجاح',
              confirmBtnText: 'حسنا',
              type: QuickAlertType.success,
              onConfirmBtnTap: () =>
                  Navigator.pushNamed(context, MainView.routeName));
        } else if (state is ChangeUserPasswordFailureState) {
          showBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding, vertical: kVerticalPadding * 3),
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                PasswordField(
                  labelText: 'كلمة المرور الحالية',
                  controller: cubit.oldPasswordController,
                  onChanged: (value) {
                    cubit.oldPasswordController.text = value;
                  },
                ),
                verticalSpace(16),
                PasswordField(
                  labelText: 'كلمة المرور الجديدة',
                  controller: cubit.newPasswordController,
                  onChanged: (value) {
                    cubit.newPasswordController.text = value;
                  },
                ),
                verticalSpace(16),
                PasswordField(
                  labelText: 'تاكيد كلمة المرور الجديدة',
                  controller: cubit.confirmNewPasswordController,
                  onChanged: (value) {
                    cubit.confirmNewPasswordController.text = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    } else if (cubit.newPasswordController.text !=
                        cubit.confirmNewPasswordController.text) {
                      return 'كلمة المرور غير متطابقة';
                    }
                    return null;
                  },
                ),
                verticalSpace(32.h),
                state is ChangeUserPasswordLoadingState
                    ? const Center(child: CustomAnimatedLoadingWidget())
                    : CustomButton(
                        text: 'تأكيد كلمةالمرور',
                        onPressed: () {
                          if (cubit.formKey.currentState?.validate() == true) {
                            cubit.changeUserPassword(
                                oldPassword: cubit.oldPasswordController.text,
                                newPassword: cubit.newPasswordController.text);
                          }
                        }),
              ],
            ),
          ),
        );
      },
    );
  }
}
