import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{}

class GetAuthStateEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
}

class LogInButtonClickEvent extends AuthEvent{
  final String email;
  final String password;
  LogInButtonClickEvent({
    required this.email,
    required this.password,
});
  @override
  List<Object?> get props => [email, password];
}

class ShowPasswordEvent extends AuthEvent{
  final bool showPassword;
  ShowPasswordEvent(this.showPassword);
  @override
  List<Object?> get props => [showPassword];
}