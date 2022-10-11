import 'dart:math';

import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authenticaiton/domain/entities/app_user.dart';
import 'package:authentication/features/authenticaiton/domain/repositories/auth_repository.dart';
import 'package:authentication/features/authenticaiton/domain/use_cases/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase.mocks.dart';

@GenerateMocks([AuthRepository])
void main(){
  
  late LoginUseCase loginUseCase;
  late MockAuthRepository authRepository;
  
  setUp((){
    authRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(authRepository);
  });


  group('login', () {
    final tEmail = 'email';
    final tPassword = 'password';
    final tAppUser = AppUser(email: 'test@email.com', uid: 'uid');

    test('should return app user when login is successful', () async {
      //arrange
      when(authRepository.logIn(email: tEmail, password: tPassword)).thenAnswer((_) async => Right(tAppUser));
      //act
      final result = await loginUseCase(LoginParams(email: tEmail, password: tPassword));
      //assert
      verify(authRepository.logIn(email: tEmail,password: tPassword));
      expect(result, Right(tAppUser));
    });

    final failure = LoginFailure('Login failed due to some reason');
    test('should return LoginFailure when login is unsuccessful', () async {
      //arrange
      when(authRepository.logIn(email: tEmail, password: tPassword)).thenAnswer((_) async => Left(failure));
      //act
      final result = await loginUseCase(LoginParams(email: tEmail, password: tPassword));
      //assert
      verify(authRepository.logIn(email: tEmail,password: tPassword));
      expect(result, Left(failure));
    });
  });
}