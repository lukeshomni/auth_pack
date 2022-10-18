import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authentication/data/data_sources/login/login.dart';
import 'package:authentication/features/authentication/data/data_sources/sign_up/sign_up.dart';
import 'package:authentication/features/authentication/domain/use_cases/get_user_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/is_authenticated_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/logout_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/sign_up_usecase.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserUseCase getUserUseCase;
  final IsAuthenticatedUseCase isAuthenticatedUseCase;
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogOutUseCase logOutUseCase;
  late final Function onUserAuthenticatedCallback;

  AuthBloc({
    required this.getUserUseCase,
    required this.isAuthenticatedUseCase,
    required this.logOutUseCase,
    required this.loginUseCase,
    required this.signUpUseCase,
  }) : super(Empty()) {
    on<GetAuthStateEvent>(_getAuthStatus);
    on<LogInButtonClickEvent>(_login);
    on<SignUpButtonClickEvent>(_signUp);
    on<LogOutEvent>(_logOut);
    on<ShowLoginScreenEvent>(_showLoginScreen);
    on<ShowSignUpScreenEvent>(_showSignUpScreen);
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
        emit(ShowLoginScreen());
    });
  }

  _login(LogInButtonClickEvent event, Emitter<AuthState> emit) async {
    emit(Loading());

    final result =
    await loginUseCase(LoginParams(loginMethod: LoginMethod.emailAndPassword, email: event.email, password: event.password));

    result.fold(
          (l) {
        emit(Error(l.message));
      },
          (r) {
        onUserAuthenticatedCallback();
      },
    );
  }



  _signUp(SignUpButtonClickEvent event, Emitter<AuthState> emit) async {
    emit(Loading());

    final result =
    await signUpUseCase(SignUpParams(signUpMethod: SignUpMethod.emailAndPassword, email: event.email, password: event.password));

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

  _showLoginScreen(ShowLoginScreenEvent event, Emitter<AuthState> emit) async {
    emit(ShowLoginScreen());
  }

  _showSignUpScreen(ShowSignUpScreenEvent event, Emitter<AuthState> emit) async {
    emit(ShowSignUpScreen());
  }
}
