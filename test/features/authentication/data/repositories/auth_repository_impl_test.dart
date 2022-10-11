import 'package:authentication/core/errors/exceptions.dart';
import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/features/authenticaiton/data/data_sources/auth_local_datasource.dart';
import 'package:authentication/features/authenticaiton/data/data_sources/auth_remote_datasource.dart';
import 'package:authentication/features/authenticaiton/data/models/app_user_model.dart';
import 'package:authentication/features/authenticaiton/data/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main(){

  late AuthRepositoryImpl authRepository;
  late MockAuthRemoteDataSource authRemoteDataSource;
  late MockAuthLocalDataSource authLocalDataSource;

  setUp((){
    authRemoteDataSource = MockAuthRemoteDataSource();
    authLocalDataSource = MockAuthLocalDataSource();
    authRepository = AuthRepositoryImpl(remoteDataSource:  authRemoteDataSource, localDataSource:  authLocalDataSource);
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


      test('Should return user not found failure when a user is not present', () async {
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

    void isAuthenticatedTest(bool isLoggedIn){
      test('Should return true when a user is present', () async {
        //arrange
        when(authRemoteDataSource.isAuthenticated()).thenAnswer((_) async => isLoggedIn);
        //act
        final result = await authRepository.isAuthenticated();
        //assert
        verify(authRemoteDataSource.isAuthenticated());
        verifyNoMoreInteractions(authLocalDataSource);
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
        when(authRemoteDataSource.isAuthenticated()).thenThrow(AuthException());
        //act
        final result = await authRepository.isAuthenticated();
        //assert
        verify(authRemoteDataSource.isAuthenticated());
        verifyNoMoreInteractions(authLocalDataSource);
        expect(result, Left(AuthFailure(somethingWrong)));
      });
    });


    group('logIn', () {
      test('Should return an App User when login is successful', () async {
        //arrange
        when(authRemoteDataSource.logIn(email: tEmail, password: tPassword)).thenAnswer((_) async => tAppUser);
        //act
        final result = await authRepository.logIn(email: tEmail, password: tPassword);
        //assert
        verify(authRemoteDataSource.logIn(email: tEmail, password: tPassword));
        expect(result, Right(tAppUser));
      });


      test('Should return Auth Failure when user enters invalid credentials', () async {
        //arrange
        when(authRemoteDataSource.logIn(email: tEmail, password: tPassword)).thenThrow(InValidCredentialsException());
        //act
        final result = await authRepository.logIn(email: tEmail, password: tPassword);
        //assert
        verify(authRemoteDataSource.logIn(email: tEmail, password: tPassword));
        expect(result, Left(AuthFailure(invalidCredentials)));
      });


      test('Should return Auth Failure when something goes wrong', () async {
        //arrange
        when(authRemoteDataSource.logIn(email: tEmail, password: tPassword)).thenThrow(Exception());
        //act
        final result = await authRepository.logIn(email: tEmail, password: tPassword);
        //assert
        verify(authRemoteDataSource.logIn(email: tEmail, password: tPassword));
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