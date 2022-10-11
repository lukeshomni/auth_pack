import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;
  Failure(this.message);
}

class LoginFailure extends Failure{
  final String message;
  LoginFailure(this.message) : super(message);

  @override
  List<Object?> get props => [message];
}

class LogOutFailure extends Failure{
  final String message;
  LogOutFailure(this.message) : super(message);

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure{
  final String message;
  AuthFailure(this.message) : super(message);

  @override
  List<Object?> get props => [message];
}

const String userNotFound = 'User not found';
const String somethingWrong = ' Something went wrong please try again';
const String invalidCredentials = 'Please enter valid email and password';