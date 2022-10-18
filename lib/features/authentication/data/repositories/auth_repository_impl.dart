import 'dart:developer';

import 'package:authentication/core/errors/exceptions.dart';
import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/features/authentication/data/data_sources/auth_local_datasource.dart';
import 'package:authentication/features/authentication/data/data_sources/auth_remote_datasource.dart';
import 'package:authentication/features/authentication/data/data_sources/sign_up/sign_up.dart';
import 'package:authentication/features/authentication/data/models/app_user_model.dart';
import 'package:authentication/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data_sources/login/login.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AppUserModel>> getCurrentUser() async {
    try {
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
    } catch (e) {
      if (e is UserNotFoundException) return Right(false);
      return Left(AuthFailure(somethingWrong));
    }
  }

  @override
  Future<Either<Failure, AppUserModel>> logIn(
      {required LoginMethod loginMethod,
      required String email,
      required String password}) async {
    try {
      final user = await remoteDataSource.logIn(
          loginMethod: loginMethod, email: email, password: password);
      return Right(user);
    } on InValidCredentialsException catch (e) {
      return Left(AuthFailure(invalidCredentials));
    } on UserNotFoundException catch (e) {
      return Left(AuthFailure(userNotFound));
    } catch (e) {
      return Left(AuthFailure(somethingWrong));
    }
  }

  @override
  Future<Either<Failure, AppUserModel>> signUp(
      {required SignUpMethod signUpMethod,
      required String email,
      required String password}) async {
    try {
      final user = await remoteDataSource.signUp(
          signUpMethod: signUpMethod, email: email, password: password);
      return Right(user);
    } catch (e) {
      if (e is InValidCredentialsException) {
        return Left(AuthFailure(invalidCredentials));
      } else if(e is UserAlreadyExistsException){
        return Left(AuthFailure(userAlreadyExists));
      } else if(e is WeakPasswordException){
        return Left(AuthFailure(weakPassword));
      }
        return Left(AuthFailure(somethingWrong));
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
