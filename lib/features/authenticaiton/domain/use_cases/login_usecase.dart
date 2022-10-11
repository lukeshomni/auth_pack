import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/features/authenticaiton/domain/entities/app_user.dart';
import 'package:authentication/features/authenticaiton/domain/repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';

class LoginUseCase extends UseCase {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);
  @override
  Future<Either<Failure, AppUser>> call(params) {
    return authRepository.logIn(email: params.email, password: params.password);
  }
}