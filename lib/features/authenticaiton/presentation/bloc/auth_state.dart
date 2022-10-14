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

class Authenticated extends AuthState{
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState{
  @override
  List<Object?> get props => [];
}

class Error extends AuthState{
  final String errorMessage;
  Error(this.errorMessage);
  @override
  List<Object?> get props => [];
}

class ShowPassword extends AuthState{
  final bool showPassword;
  ShowPassword(this.showPassword);

  @override
  List<Object?> get props => [showPassword];
}