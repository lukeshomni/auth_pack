import 'package:authentication/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class GetUserUseCase extends UseCase{
  final AuthRepository authRepository;

  GetUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return authRepository.getCurrentUser();
  }
}