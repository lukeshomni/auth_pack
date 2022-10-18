import 'package:authentication/core/errors/exceptions.dart';
import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/features/authentication/data/data_sources/auth_local_datasource.dart';
import 'package:authentication/features/authentication/data/data_sources/auth_remote_datasource.dart';
import 'package:authentication/features/authentication/data/data_sources/login/login.dart';
import 'package:authentication/features/authentication/data/data_sources/sign_up/sign_up.dart';
import 'package:authentication/features/authentication/data/models/app_user_model.dart';
import 'package:authentication/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  late AuthRepositoryImpl authRepository;
  late MockAuthRemoteDataSource authRemoteDataSource;
  late MockAuthLocalDataSource authLocalDataSource;

  setUp(() {
    authRemoteDataSource = MockAuthRemoteDataSource();
    authLocalDataSource = MockAuthLocalDataSource();
    authRepository = AuthRepositoryImpl(
        remoteDataSource: authRemoteDataSource,
        localDataSource: authLocalDataSource);
  });

  group('authRepository', () {
    final tEmail = 'test@email.com';
    final tUid = 'uuid';
    final tPassword = 'password';
    final tAppUser = AppUserModel(email: tEmail, uid: tUid);

    group('getUser', () {
      test('Should return AppUserModel when a user is present', () async {
        //arrange
        when(authLocalDataSource.getUser()).thenAnswer((_) async => tAppUser);
        //act
        final result = await authRepository.getCurrentUser();
        //assert
        verify(authLocalDataSource.getUser());
        verifyNoMoreInteractions(authRemoteDataSource);
        expect(result, Right(tAppUser));
      });

      test('Should return user not found failure when a user is not present',
          () async {
        //arrange
        when(authLocalDataSource.getUser()).thenThrow(UserNotFoundException());
        //act
        final result = await authRepository.getCurrentUser();
        //assert
        verify(authLocalDataSource.getUser());
        verifyNoMoreInteractions(authRemoteDataSource);
        expect(result, Left(AuthFailure(userNotFound)));
      });
    });

    void isAuthenticatedTest(bool isLoggedIn) {
      test('Should return true when a user is present', () async {
        //arrange
        if (isLoggedIn) {
          when(authLocalDataSource.getUser()).thenAnswer((_) async => tAppUser);
        } else {
          when(authLocalDataSource.getUser())
              .thenThrow(UserNotFoundException());
        }
        //act
        final result = await authRepository.isAuthenticated();
        //assert
        verify(authLocalDataSource.getUser());
        expect(result, Right(isLoggedIn));
      });
    }

    group('isAuthenticated', () {
      // is authenticated test when user is logged in
      isAuthenticatedTest(true);

      // is authenticated test when user is not logged in
      isAuthenticatedTest(false);

      test('Should return auth failure when something goes wrong', () async {
        //arrange
        when(authLocalDataSource.getUser()).thenThrow(AuthException());
        //act
        final result = await authRepository.isAuthenticated();
        //assert
        verify(authLocalDataSource.getUser());
        expect(result, Left(AuthFailure(somethingWrong)));
      });
    });

    group('logIn', () {
      test('Should return an App User when login is successful', () async {
        //arrange
        when(authRemoteDataSource.logIn(email: tEmail, password: tPassword, loginMethod: LoginMethod.emailAndPassword))
            .thenAnswer((_) async => tAppUser);
        //act
        final result =
            await authRepository.logIn(email: tEmail, password: tPassword, loginMethod: LoginMethod.emailAndPassword);
        //assert
        verify(authRemoteDataSource.logIn(email: tEmail, password: tPassword, loginMethod: LoginMethod.emailAndPassword));
        expect(result, Right(tAppUser));
      });

      test('Should return Auth Failure when user enters invalid credentials',
          () async {
        //arrange
        when(authRemoteDataSource.logIn(email: tEmail, password: tPassword, loginMethod: LoginMethod.emailAndPassword))
            .thenThrow(InValidCredentialsException());
        //act
        final result =
            await authRepository.logIn(email: tEmail, password: tPassword, loginMethod: LoginMethod.emailAndPassword);
        //assert
        verify(authRemoteDataSource.logIn(email: tEmail, password: tPassword, loginMethod: LoginMethod.emailAndPassword));
        expect(result, Left(AuthFailure(invalidCredentials)));
      });

      test('Should return Auth Failure when something goes wrong', () async {
        //arrange
        when(authRemoteDataSource.logIn(email: tEmail, password: tPassword, loginMethod: LoginMethod.emailAndPassword))
            .thenThrow(Exception());
        //act
        final result =
            await authRepository.logIn(email: tEmail, password: tPassword, loginMethod: LoginMethod.emailAndPassword);
        //assert
        verify(authRemoteDataSource.logIn(email: tEmail, password: tPassword, loginMethod: LoginMethod.emailAndPassword));
        expect(result, Left(AuthFailure(somethingWrong)));
      });
    });

    group('signUp', () {
      test('Should return an App User when signUp is successful', () async {
        //arrange
        when(authRemoteDataSource.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword))
            .thenAnswer((_) async => tAppUser);
        //act
        final result =
        await authRepository.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword);
        //assert
        verify(authRemoteDataSource.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword));
        expect(result, Right(tAppUser));
      });

      test('Should return Auth Failure when user enters invalid credentials',
              () async {
            //arrange
            when(authRemoteDataSource.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword))
                .thenThrow(InValidCredentialsException());
            //act
            final result =
            await authRepository.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword);
            //assert
            verify(authRemoteDataSource.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword));
            expect(result, Left(AuthFailure(invalidCredentials)));
          });

      test('Should return Auth Failure when something goes wrong', () async {
        //arrange
        when(authRemoteDataSource.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword))
            .thenThrow(Exception());
        //act
        final result =
        await authRepository.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword);
        //assert
        verify(authRemoteDataSource.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword));
        expect(result, Left(AuthFailure(somethingWrong)));
      });
    });

    group('logOut', () {
      test('Should logout the user', () async {
        //arrange
        when(authLocalDataSource.logOut()).thenAnswer((_) async => null);
        //act
        await authRepository.logOut();
        //assert
        verify(authLocalDataSource.logOut());
        verifyNoMoreInteractions(authRemoteDataSource);
      });

      test('Should return Auth Failure when something goes wrong', () async {
        //arrange
        when(authLocalDataSource.logOut()).thenThrow(Exception());
        //act
        final result = await authRepository.logOut();
        //assert
        verify(authLocalDataSource.logOut());
        verifyNoMoreInteractions(authRemoteDataSource);
        expect(result, Left(AuthFailure(somethingWrong)));
      });
    });
  });
}
