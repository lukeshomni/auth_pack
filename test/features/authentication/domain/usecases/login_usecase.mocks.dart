// Mocks generated by Mockito 5.3.2 from annotations
// in authentication/test/features/authentication/domain/usecases/login_usecase.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:authentication/core/errors/failures.dart' as _i5;
import 'package:authentication/features/authentication/data/data_sources/login/login.dart'
    as _i7;
import 'package:authentication/features/authentication/data/data_sources/sign_up/sign_up.dart'
    as _i8;
import 'package:authentication/features/authentication/domain/entities/app_user.dart'
    as _i6;
import 'package:authentication/features/authentication/domain/repositories/auth_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> isAuthenticated() =>
      (super.noSuchMethod(
        Invocation.method(
          #isAuthenticated,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #isAuthenticated,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.AppUser>> getCurrentUser() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentUser,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.AppUser>>.value(
            _FakeEither_0<_i5.Failure, _i6.AppUser>(
          this,
          Invocation.method(
            #getCurrentUser,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.AppUser>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.AppUser>> logIn({
    required _i7.LoginMethod? loginMethod,
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #logIn,
          [],
          {
            #loginMethod: loginMethod,
            #email: email,
            #password: password,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.AppUser>>.value(
            _FakeEither_0<_i5.Failure, _i6.AppUser>(
          this,
          Invocation.method(
            #logIn,
            [],
            {
              #loginMethod: loginMethod,
              #email: email,
              #password: password,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.AppUser>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.AppUser>> signUp({
    required _i8.SignUpMethod? signUpMethod,
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [],
          {
            #signUpMethod: signUpMethod,
            #email: email,
            #password: password,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.AppUser>>.value(
            _FakeEither_0<_i5.Failure, _i6.AppUser>(
          this,
          Invocation.method(
            #signUp,
            [],
            {
              #signUpMethod: signUpMethod,
              #email: email,
              #password: password,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.AppUser>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> logOut() => (super.noSuchMethod(
        Invocation.method(
          #logOut,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #logOut,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
}
