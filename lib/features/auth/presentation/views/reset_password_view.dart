import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/core/widgets/custom_app_bar.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:nafsia_app/features/auth/presentation/views/widget/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.otp});
  static const routeName = '/resetPasswordView';
  final String otp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetPasswordCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(context,
            title: 'كلمة مرور جديدة', onTap: () => Navigator.pop(context)),
        body: ResetPasswordViewBody(otp: otp),
      ),
    );
  }
}
