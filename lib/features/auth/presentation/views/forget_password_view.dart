import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/repos/auth_repo.dart';
import '../cubits/forget_password_cubit/forget_password_cubit.dart';
import 'widget/forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  static const route = '/forgetPasswordView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(context,
            title: 'نسيت كلمة المرور', onTap: () => Navigator.pop(context)),
        body: const ForgetPasswordViewBody(),
      ),
    );
  }
}
