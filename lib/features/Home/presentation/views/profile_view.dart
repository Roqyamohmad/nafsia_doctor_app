import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/features/Home/presentation/cubits/more_cubit/more_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/views/profile_view_widgets/profile_view_body.dart';
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routename = 'profileView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'الملف الشخصي',
        onTap: () => Navigator.pop(context),
      ),
      body: BlocProvider(
        create: (context) => MoreCubit(getIt<AuthRepo>()),
        child: const ProfileViewBody(),
      ),
    );
  }
}
