import 'package:get_it/get_it.dart';
import 'package:mobile_assistant_ia/features/auth/data/repositories/auth_repository.dart';
import 'package:mobile_assistant_ia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_assistant_ia/features/chat/data/repositories/chat_repository.dart';
import 'package:mobile_assistant_ia/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:mobile_assistant_ia/features/agenda/data/repositories/agenda_repository.dart';
import 'package:mobile_assistant_ia/features/agenda/presentation/bloc/agenda_bloc.dart';
import 'package:mobile_assistant_ia/services/api/api_client.dart';
import 'package:mobile_assistant_ia/services/storage/secure_storage.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // === SERVICES ===
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());

  // === REPOSITORIES ===
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepository(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<AgendaRepository>(
    () => AgendaRepository(getIt<ApiClient>()),
  );

  // === BLOCS ===
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt<AuthRepository>()),
  );

  getIt.registerFactory<ChatBloc>(
    () => ChatBloc(getIt<ChatRepository>()),
  );

  getIt.registerFactory<AgendaBloc>(
    () => AgendaBloc(getIt<AgendaRepository>()),
  );
}