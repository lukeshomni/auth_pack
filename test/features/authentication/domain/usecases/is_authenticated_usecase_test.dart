import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authenticaiton/domain/use_cases/is_authenticated_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'login_usecase.mocks.dart';

void main(){
  late IsAuthenticated isAuthenticatedUseCase;
  late MockAuthRepository authRepository;

  setUp((){
    authRepository = MockAuthRepository();
    isAuthenticatedUseCase= IsAuthenticated(authRepository);
  });


  void testIfUserLoggedIn(bool loggedIN){
    test("should return $loggedIN when user is " + (loggedIN? '' : 'not ') + 'logged in.', () async {
      //arrange
      when(authRepository.isAuthenticated()).thenAnswer((_) async => Right(loggedIN));
      //act
      final result = await isAuthenticatedUseCase(NoParams());
      //assert
      verify(authRepository.isAuthenticated());
      expect(result, Right(loggedIN));
    });
  }


  group('isUserLoggedIn', () {

    testIfUserLoggedIn(true);
    testIfUserLoggedIn(false);

    final failure = AuthFailure('Cannot get authentication status');
    test('should return LoginFailure when login is unsuccessful', () async {
      //arrange
      when(authRepository.isAuthenticated()).thenAnswer((_) async => Left(failure));
      //act
      final result = await isAuthenticatedUseCase(NoParams());
      //assert
      verify(authRepository.isAuthenticated());
      expect(result, Left(failure));
    });
  });
}