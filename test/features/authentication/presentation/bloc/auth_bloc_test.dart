import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/features/authentication/domain/entities/app_user.dart';
import 'package:authentication/features/authentication/domain/use_cases/get_user_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/is_authenticated_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/logout_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/sign_up_usecase.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_bloc_test.mocks.dart';

@GenerateMocks([GetUserUseCase, IsAuthenticatedUseCase, LoginUseCase, LogOutUseCase, SignUpUseCase])

void main(){
  late AuthBloc authBloc;
  late MockGetUserUseCase getUser;
  late MockIsAuthenticatedUseCase isAuthenticated;
  late MockLoginUseCase login;
  late MockSignUpUseCase signUp;
  late MockLogOutUseCase logOut;



  final Function onAuthenticatedCallback = () {
    print("hello");
  };

  void setUpBloc() {
    getUser = MockGetUserUseCase();
    isAuthenticated = MockIsAuthenticatedUseCase();
    logOut = MockLogOutUseCase();
    login = MockLoginUseCase();
    signUp = MockSignUpUseCase();
    authBloc = AuthBloc(getUserUseCase: getUser, isAuthenticatedUseCase: isAuthenticated, logOutUseCase: logOut, loginUseCase: login, signUpUseCase: signUp);
    authBloc.onUserAuthenticatedCallback = onAuthenticatedCallback;
  };

   group('getAuthStatus', () {

     void mockLoggedIn(bool loggedIn){
       when(isAuthenticated(any)).thenAnswer((_) async => Right(loggedIn));
     }
     void mockLoggedInFailure(){
       when(isAuthenticated(any)).thenAnswer((_) async => Left(AuthFailure(somethingWrong)));
     }
     blocTest(
       'emit [Loading] when getAuthStatus occurs and user is logged in',
       setUp: () {
         setUpBloc();
         mockLoggedIn(true);
         return authBloc;
       },
       act: (bloc) => bloc.add(GetAuthStateEvent()),
       expect: () => [Loading()],
       verify: (verify) => [isAuthenticated, onAuthenticatedCallback],
       build: () => authBloc,
     );

     blocTest(
       'emit [Loading, UnAuthenticated] when getAuthStatus occurs when user is not logged in',
       setUp: () {
         setUpBloc();
         mockLoggedIn(false);
         return authBloc;
       },
       act: (bloc) => bloc.add(GetAuthStateEvent()),
       expect: () => [Loading(), ShowLoginScreen()],
       verify: (verify) => isAuthenticated,
       build: () => authBloc,
     );

     blocTest(
       'emit [Loading, Error] when isAuthenticated returns Failure',
       setUp: () {
         setUpBloc();
         mockLoggedInFailure();
         return authBloc;
       },
       act: (bloc) => bloc.add(GetAuthStateEvent()),
       expect: () => [Loading(), Error(somethingWrong)],
       verify: (verify) => isAuthenticated,
       build: () => authBloc,
     );
   });


  group('login', () {
    final tEmail = 'test@email.com';
    final tPassword = 'password';
    final tUid = 'uid';
    final tAppUser = AppUser(email: tEmail, uid: tUid);

    void mockLoggedIn(bool loggedIn){
      when(login(any)).thenAnswer((_) async => loggedIn ? Right(tAppUser) : Left(AuthFailure(invalidCredentials)));
    }
    void mockLoggedInFailure(){
      when(login(any)).thenAnswer((_) async => Left(AuthFailure(somethingWrong)));
    }

    blocTest(
      'emit [Loading] when login is successful',
      setUp: () {
        setUpBloc();
        mockLoggedIn(true);
        return authBloc;
      },
      act: (bloc) => bloc.add(LogInButtonClickEvent(email: tEmail, password: tPassword)),
      expect: () => [Loading(), ],
      verify: (verify) => [login, onAuthenticatedCallback],
      build: () => authBloc,
    );

    blocTest(
      'emit [Loading, Error(invalid credentials)] when login is not successful',
      setUp: () {
        setUpBloc();
        mockLoggedIn(false);
        return authBloc;
      },
      act: (bloc) => bloc.add(LogInButtonClickEvent(email: tEmail, password: tPassword)),
      expect: () => [Loading(), Error(invalidCredentials)],
      verify: (verify) => login,
      build: () => authBloc,
    );

    blocTest(
      'emit [Loading, Error] when login fails',
      setUp: () {
        setUpBloc();
        mockLoggedInFailure();
        return authBloc;
      },
      act: (bloc) => bloc.add(LogInButtonClickEvent(email: tEmail, password: tPassword)),
      expect: () => [Loading(), Error(somethingWrong)],
      verify: (verify) => isAuthenticated,
      build: () => authBloc,
    );


  });
}
