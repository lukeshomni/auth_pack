import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authentication/domain/use_cases/logout_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase.mocks.dart';

void main(){
  late LogOutUseCase logOutUsecase;
  late MockAuthRepository authRepository;

  setUp((){
    authRepository = MockAuthRepository();
    logOutUsecase = LogOutUseCase(authRepository);
  });


  group('logout', () {

    test("should call repository's logOut", () async {
      //arrange
      when(authRepository.logOut()).thenAnswer((_) async => Right(null));
      //act
      final result = await logOutUsecase(NoParams());
      //assert
      verify(authRepository.logOut());
      expect(result, Right(null));
    });

    final failure = LogOutFailure('Login failed due to some reason');
    test('should return LogOutFailure when logout is unsuccessful', () async {
      //arrange
      when(authRepository.logOut()).thenAnswer((_) async => Left(failure));
      //act
      final result = await logOutUsecase(NoParams());
      //assert
      verify(authRepository.logOut());
      expect(result, Left(failure));
    });
  });
}