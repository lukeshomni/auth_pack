import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authentication/data/data_sources/sign_up/sign_up.dart';
import 'package:authentication/features/authentication/domain/entities/app_user.dart';
import 'package:authentication/features/authentication/domain/repositories/auth_repository.dart';
import 'package:authentication/features/authentication/domain/use_cases/sign_up_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main(){

  late SignUpUseCase signUpUseCase;
  late MockAuthRepository authRepository;

  setUp((){
    authRepository = MockAuthRepository();
    signUpUseCase = SignUpUseCase(authRepository);
  });


  group('signUp', () {
    final tEmail = 'email';
    final tPassword = 'password';
    final tAppUser = AppUser(email: 'test@email.com', uid: 'uid');

    test('should return app user when signUp is successful', () async {
      //arrange
      when(authRepository.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword)).thenAnswer((_) async => Right(tAppUser));
      //act
      final result = await signUpUseCase(SignUpParams(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword));
      //assert
      verify(authRepository.signUp(email: tEmail,password: tPassword, signUpMethod: SignUpMethod.emailAndPassword));
      expect(result, Right(tAppUser));
    });

    final failure = SignUpFailure('Login failed due to some reason');
    test('should return SignUpFailure when login is unsuccessful', () async {
      //arrange
      when(authRepository.signUp(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword)).thenAnswer((_) async => Left(failure));
      //act
      final result = await signUpUseCase(SignUpParams(email: tEmail, password: tPassword, signUpMethod: SignUpMethod.emailAndPassword));
      //assert
      verify(authRepository.signUp(email: tEmail,password: tPassword, signUpMethod: SignUpMethod.emailAndPassword));
      expect(result, Left(failure));
    });
  });
}