import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/core/utils/app_colors.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart'
    show AuthRepo;
import 'package:nafsia_app/features/auth/presentation/views/widget/signup_view_body_bloc_consumer.dart';

import '../cubits/signup_cubits/signup_cubit.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const routeName = 'signup';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthRepo>(),
      ),
      child: const Scaffold(
        backgroundColor: AppColors.backGroundyColor,
        body: SafeArea(
          child: SignupViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
