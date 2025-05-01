import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nafsia_app/core/helper_functions/build_error_bar.dart';
import 'package:nafsia_app/features/auth/presentation/cubits/signin_cubits/signin_state.dart';

import '../../../../Home/presentation/views/main_view.dart';
import '../../cubits/signin_cubits/signin_cubit.dart';
import 'signin_view_body.dart';

class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccessState) {
          Navigator.pushNamed(context, MainView.routeName);
          showBar(context, state.message);
        }

        if (state is SigninFailureState) {
          showBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SigninLoadingState ? true : false,
          child: const SigninViewBody(),
        );
      },
    );
  }
}
