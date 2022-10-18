import 'package:equatable/equatable.dart';
abstract class AuthState extends Equatable{}

class Empty extends AuthState{
  @override
  List<Object?> get props => [];
}

class Loading extends AuthState{
  @override
  List<Object?> get props => [];
}

class ShowLoginScreen extends AuthState{
  @override
  List<Object?> get props => [];
}

class ShowSignUpScreen extends AuthState{
  @override
  List<Object?> get props => [];
}

class Error extends AuthState{
  final String errorMessage;
  Error(this.errorMessage);
  @override
  List<Object?> get props => [];
}