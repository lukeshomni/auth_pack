import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authentication/domain/entities/app_user.dart';
import 'package:authentication/features/authentication/domain/use_cases/get_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase.mocks.dart';

void main(){

  late GetUser getUserUseCase;
  late MockAuthRepository authRepository;

  setUp((){
    authRepository = MockAuthRepository();
    getUserUseCase = GetUser(authRepository);
  });


  group('getUser', () {
    final tEmail = 'email';
    final tPassword = 'password';
    final tAppUser = AppUser(email: 'test@email.com', uid: 'uid');

    test('should return app user when user is Logged In', () async {
      //arrange
      when(authRepository.getCurrentUser()).thenAnswer((_) async => Right(tAppUser));
      //act
      final result = await getUserUseCase(NoParams());
      //assert
      verify(authRepository.getCurrentUser());
      verifyNoMoreInteractions(authRepository);
      expect(result, Right(tAppUser));
    });

    final failure = AuthFailure('No User found');
    test('should return LoginFailure when login is unsuccessful', () async {
      //arrange
      when(authRepository.getCurrentUser()).thenAnswer((_) async => Left(failure));
      //act
      final result = await getUserUseCase(NoParams());
      //assert
      verify(authRepository.getCurrentUser());
      verifyNoMoreInteractions(authRepository);
      expect(result, Left(failure));
    });
  });
}