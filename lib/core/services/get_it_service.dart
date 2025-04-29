import 'package:nafsia_app/core/services/firestore_service.dart';
import 'package:nafsia_app/features/auth/data/repo/auth_repo_impl.dart'
    show AuthRepoImpl;
import 'package:nafsia_app/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import 'data_service.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      databaseService: getIt<DatabaseService>(),
    ),
  );
}
