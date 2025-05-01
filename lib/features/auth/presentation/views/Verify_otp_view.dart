// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/core/widgets/custom_app_bar.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';

import 'widget/verify_otp_view_body.dart.dart';

class VerifyOtpView extends StatelessWidget {
  final String email;
  static const route = '/verifyOtpView';
  const VerifyOtpView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetPasswordCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(context,
            title: 'التحقق من الرمز', onTap: () => Navigator.pop(context)),
        body: VerifyOtpViewBody(email: email),
      ),
    );
  }
}
