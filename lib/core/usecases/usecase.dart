import 'package:authentication/features/authentication/data/data_sources/login/login.dart';
import 'package:authentication/features/authentication/data/data_sources/sign_up/sign_up.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginParams extends Equatable {
  final String email;
  final String password;
  final LoginMethod loginMethod;
  LoginParams({
    required this.loginMethod,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password, loginMethod];
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final SignUpMethod signUpMethod;
  SignUpParams({
    required this.signUpMethod,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password, signUpMethod];
}
