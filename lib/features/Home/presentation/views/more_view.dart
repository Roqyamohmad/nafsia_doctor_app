import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/features/Home/presentation/views/profile_view_widgets/more_view_body.dart';
import '../../../auth/domain/repos/auth_repo.dart';
import '../cubits/more_cubit/more_cubit.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreCubit(getIt<AuthRepo>()),
      child: const MoreViewBody(),
    );
  }
}
