import 'package:get_it/get_it.dart';
import 'package:mobile_assistant_ia/features/auth/data/repositories/auth_repository.dart';
import 'package:mobile_assistant_ia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_assistant_ia/services/api/api_client.dart';
import 'package:mobile_assistant_ia/services/storage/secure_storage.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Services
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<ApiClient>()),
  );

  // BLoCs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt<AuthRepository>()),
  );
}