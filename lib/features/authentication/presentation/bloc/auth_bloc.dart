import 'dart:math';

import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/get_user_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/is_authenticated_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/logout_usecase.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUser getUser;
  final IsAuthenticated isAuthenticated;
  final Login login;
  final LogOut logOut;
  late final Function onUserAuthenticatedCallback;

  AuthBloc({
    required this.getUser,
    required this.isAuthenticated,
    required this.logOut,
    required this.login,
  }) : super(Empty()) {
    on<GetAuthStateEvent>(_getAuthStatus);
    on<ShowPasswordEvent>(_showPassword);
    on<LogInButtonClickEvent>(_login);
    on<LogOutEvent>(_logOut);
  }

  _getAuthStatus(GetAuthStateEvent event, Emitter<AuthState> emit) async {
    emit(Loading());
    //
    final result = await isAuthenticated(NoParams());
    result.fold((l) {
      emit(Error(l.message));
    }, (r) {
      if (r)
        onUserAuthenticatedCallback();
      else
        emit(UnAuthenticated());
    });
  }

  _showPassword(ShowPasswordEvent event, Emitter<AuthState> emit) {
    emit(ShowPassword(event.showPassword));
  }

  _login(LogInButtonClickEvent event, Emitter<AuthState> emit) async {
    emit(Loading());

    final result =
        await login(LoginParams(email: event.email, password: event.password));

    result.fold(
      (l) {
        emit(Error(l.message));
      },
      (r) {
        onUserAuthenticatedCallback();
      },
    );
  }

  _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    await logOut(NoParams());
    event.onLoggedOutCallBack();
  }
}