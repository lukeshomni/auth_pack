import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class IsAuthenticatedUseCase extends UseCase{

  final AuthRepository authRepository;

  IsAuthenticatedUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(params) {
    return authRepository.isAuthenticated();
  }
}