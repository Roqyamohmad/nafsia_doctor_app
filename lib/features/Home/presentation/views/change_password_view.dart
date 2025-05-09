import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../cubits/more_cubit/more_cubit.dart';
import 'profile_view_widgets/change_password_view_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});
  static const routename = 'changePasswordView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: buildAppBar(context,
            title: 'إعادة تعيين كلمة المرور',
            onTap: () => Navigator.pop(context)),
        body: const ChangePasswordViewBody(),
      ),
    );
  }
}
