import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogOutUseCase extends UseCase {
  final AuthRepository authRepository;

  LogOutUseCase(this.authRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return authRepository.logOut();
  }
}
