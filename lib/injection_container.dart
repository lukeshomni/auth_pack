import 'package:authentication/features/authenticaiton/data/data_sources/auth_local_datasource.dart';
import 'package:authentication/features/authenticaiton/data/data_sources/auth_remote_datasource.dart';
import 'package:authentication/features/authenticaiton/data/repositories/auth_repository_impl.dart';
import 'package:authentication/features/authenticaiton/domain/repositories/auth_repository.dart';
import 'package:authentication/features/authenticaiton/domain/use_cases/get_user_usecase.dart';
import 'package:authentication/features/authenticaiton/domain/use_cases/is_authenticated_usecase.dart';
import 'package:authentication/features/authenticaiton/domain/use_cases/login_usecase.dart';
import 'package:authentication/features/authenticaiton/domain/use_cases/logout_usecase.dart';
import 'package:authentication/features/authenticaiton/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Authentication
  sl.registerFactory(() => AuthBloc(
        getUser: sl(),
        isAuthenticated: sl(),
        logOut: sl(),
        login: sl(),
      ));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => IsAuthenticated(sl()));
  sl.registerLazySingleton(() => LogOut(sl()));
  sl.registerLazySingleton(() => Login(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));

  // Data Repositories
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());

  /// Core

}
