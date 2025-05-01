import 'package:dio/dio.dart';
import 'package:nafsia_app/core/services/api_consumer.dart';
import 'package:nafsia_app/core/services/dio_consumer.dart';
import 'package:nafsia_app/features/Home/data/repos/home_repo_implementation.dart';
import 'package:nafsia_app/features/auth/data/repo/auth_repo_impl.dart'
    show AuthRepoImpl;
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/Home/data/repos/home_repo.dart';
import '../../features/Home/presentation/cubits/add_post_cubit/add_Post_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Register Dio instance
  getIt.registerSingleton<Dio>(Dio());

  // Register ApiConsumer implementation
  getIt.registerSingleton<ApiConsumer>(DioConsumer(dio: getIt<Dio>()));

  // Register AuthRepo
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt<ApiConsumer>()));
  // Register HomeRepo
  getIt.registerSingleton<HomeRepo>(
      HomeRepoImplementation(getIt<ApiConsumer>()));

  // Register AddPostCubit (factory because Cubit is stateful)
  getIt.registerFactory<AddPostCubit>(() => AddPostCubit(getIt<HomeRepo>()));
}
