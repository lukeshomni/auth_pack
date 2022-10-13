import 'package:authentication/features/authenticaiton/domain/use_cases/logout_usecase.dart';
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

class CallOnUserAuthenticatedCallback extends AuthEvent{
  final Function onUserAuthenticated;
  CallOnUserAuthenticatedCallback(this.onUserAuthenticated);
  @override
  List<Object?> get props => [onUserAuthenticated];
}

class LogOutEvent extends AuthEvent{
  final Function onLoggedOutCallBack;
  LogOutEvent(this.onLoggedOutCallBack);
  @override
  List<Object?> get props => [onLoggedOutCallBack];
}