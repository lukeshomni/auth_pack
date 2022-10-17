import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/features/authentication/domain/entities/app_user.dart';
import 'package:authentication/features/authentication/domain/repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';

class LoginUseCase extends UseCase {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);
  @override
  Future<Either<Failure, AppUser>> call(params) {
    return authRepository.logIn(loginMethod: params.loginMethod, email: params.email, password: params.password);
  }
}