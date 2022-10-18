import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/data_sources/login/login.dart';
import '../../data/data_sources/sign_up/sign_up.dart';
import '../entities/app_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> isAuthenticated();
  Future<Either<Failure, AppUser>> getCurrentUser();
  Future<Either<Failure, AppUser>> logIn({required LoginMethod loginMethod, required String email, required String password});
  Future<Either<Failure, AppUser>> signUp({required SignUpMethod signUpMethod, required String email, required String password});
  Future<Either<Failure, void>> logOut();
}