import 'package:authentication/core/errors/failures.dart';
import 'package:authentication/core/usecases/usecase.dart';
import 'package:authentication/features/authenticaiton/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LogOut extends UseCase {
  final AuthRepository authRepository;

  LogOut(this.authRepository);
  @override
  Future<Either<Failure, void>> call(params) {
    return authRepository.logOut();
  }
}
