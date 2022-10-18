import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class SignUpUseCase extends UseCase{
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return authRepository.signUp(signUpMethod: params.signUpMethod, email: params.email, password: params.password);
  }
}