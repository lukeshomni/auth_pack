
import 'dart:math';

import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/features/authentication/domain/entities/app_user.dart';
import 'package:authentication/features/authentication/domain/use_cases/get_user_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/is_authenticated_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/logout_usecase.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([GetUser, IsAuthenticated, Login, LogOut])

void main(){
  late AuthBloc authBloc;
  late MockGetUser getUser;
  late MockIsAuthenticated isAuthenticated;
  late MockLogin login;
  late MockLogOut logOut;



  final Function onAuthenticatedCallback = () {
    print("hello");
  };

  void setUpBloc() {
    getUser = MockGetUser();
    isAuthenticated = MockIsAuthenticated();
    logOut = MockLogOut();
    login = MockLogin();
    authBloc = AuthBloc(getUser: getUser, isAuthenticated: isAuthenticated, logOut: logOut, login: login);
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
       expect: () => [Loading(), UnAuthenticated()],
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


  group('showPasswordEvent', () {
    blocTest(
      'emit [Loading, showPassword] when show password event occurs with true value',
      setUp: () {
        setUpBloc();
        return authBloc;
      },
      act: (bloc) => bloc.add(ShowPasswordEvent(true)),
      expect: () => [ShowPassword(true)],
      build: () => authBloc,
    );

    blocTest(
      'emit [Loading, showPassword] when show password event occurs with false value',
      setUp: () {
        setUpBloc();
        return authBloc;
      },
      act: (bloc) => bloc.add(ShowPasswordEvent(false)),
      expect: () => [ShowPassword(false)],
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
