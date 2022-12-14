import 'package:authentication/features/authentication/data/data_sources/auth_local_datasource.dart';
import 'package:authentication/features/authentication/data/data_sources/auth_remote_datasource.dart';
import 'package:authentication/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:authentication/features/authentication/domain/repositories/auth_repository.dart';
import 'package:authentication/features/authentication/domain/use_cases/get_user_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/is_authenticated_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/logout_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/sign_up_usecase.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;


Future<void> init() async {
  /// Features - Authentication
  sl.registerFactory(() => AuthBloc(
        getUserUseCase: sl(),
        isAuthenticatedUseCase: sl(),
        logOutUseCase: sl(),
        loginUseCase: sl(),
        signUpUseCase: sl(),
      ));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => IsAuthenticatedUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));

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
