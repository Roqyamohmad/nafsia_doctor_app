import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:nafsia_app/core/services/get_it_service.dart';
import 'package:nafsia_app/features/Home/data/repos/home_repo.dart'
    show HomeRepo;
import 'package:nafsia_app/features/Home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:nafsia_app/features/Home/presentation/views/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    print(getUserData().data?.token);
    return BlocProvider(
      create: (context) => HomeCubit(getIt<HomeRepo>())..getAllPosts(),
      child: const HomeViewBody(),
    );
  }
}
