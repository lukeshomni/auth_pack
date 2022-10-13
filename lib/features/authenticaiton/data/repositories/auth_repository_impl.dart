import 'dart:developer';

import 'package:authentication/core/errors/exceptions.dart';
import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/features/authenticaiton/data/data_sources/auth_local_datasource.dart';
import 'package:authentication/features/authenticaiton/data/data_sources/auth_remote_datasource.dart';
import 'package:authentication/features/authenticaiton/data/models/app_user_model.dart';
import 'package:authentication/features/authenticaiton/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AppUserModel>> getCurrentUser() async {
    try{
      final user = await localDataSource.getUser();
      return Right(user);
    } on UserNotFoundException {
      return Left(AuthFailure(userNotFound));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final user = localDataSource.getUser();
      return Right(true);
    } catch(e) {
      if(e is UserNotFoundException) return Right(false);
      return Left(AuthFailure(somethingWrong));
    }
  }

  @override
  Future<Either<Failure, AppUserModel>> logIn(
      {required String email, required String password}) async {
    try{
      final user = await remoteDataSource.logIn(email: email, password: password);
      return Right(user);
    } catch(e){
      if(e is InValidCredentialsException){
        return Left(AuthFailure(invalidCredentials));
      } else return Left(AuthFailure(somethingWrong));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await localDataSource.logOut();
      return Right(null);
    } on Exception {
      return Left(AuthFailure(somethingWrong));
    }
  }
}
