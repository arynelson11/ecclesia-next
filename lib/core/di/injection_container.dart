import 'package:get_it/get_it.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/home/presentation/cubit/content_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  sl.registerFactory(() => AuthBloc(repository: sl()));
  
  // Features - Content
  sl.registerLazySingleton(() => ContentCubit());

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // Core
  // TODO: Registrar Network checkers, etc.

  // External
  // TODO: Registrar Firebase instances, SharedPreferences, etc.
}

