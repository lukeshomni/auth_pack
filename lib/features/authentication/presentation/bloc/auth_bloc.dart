import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/get_user_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/is_authenticated_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/logout_usecase.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserUseCase getUserUseCase;
  final IsAuthenticatedUseCase isAuthenticatedUseCase;
  final LoginUseCase loginUseCase;
  final LogOutUseCase logOutUseCase;
  late final Function onUserAuthenticatedCallback;

  AuthBloc({
    required this.getUserUseCase,
    required this.isAuthenticatedUseCase,
    required this.logOutUseCase,
    required this.loginUseCase,
  }) : super(Empty()) {
    on<GetAuthStateEvent>(_getAuthStatus);
    on<ShowPasswordEvent>(_showPassword);
    on<LogInButtonClickEvent>(_login);
    on<LogOutEvent>(_logOut);
  }

  _getAuthStatus(GetAuthStateEvent event, Emitter<AuthState> emit) async {
    emit(Loading());
    //
    final result = await isAuthenticatedUseCase(NoParams());
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
        await loginUseCase(LoginParams(email: event.email, password: event.password));

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
    await logOutUseCase(NoParams());
    event.onLoggedOutCallBack();
  }
}
