// Mocks generated by Mockito 5.3.2 from annotations
// in password_safe/test/application/password/controller/controller_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:password_safe/core/failures/password_failures.dart' as _i5;
import 'package:password_safe/domain/entities/password.dart' as _i6;
import 'package:password_safe/domain/repositories/password_repository.dart'
    as _i3;

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

/// A class which mocks [PasswordRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPasswordRepository extends _i1.Mock
    implements _i3.PasswordRepository {
  MockPasswordRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Stream<_i2.Either<_i5.PasswordFailure, List<_i6.Password>>> getAll() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i4.Stream<
            _i2.Either<_i5.PasswordFailure, List<_i6.Password>>>.empty(),
      ) as _i4.Stream<_i2.Either<_i5.PasswordFailure, List<_i6.Password>>>);
  @override
  _i4.Future<_i2.Either<_i5.PasswordFailure, _i2.Unit>> create(
          _i6.Password? password) =>
      (super.noSuchMethod(
        Invocation.method(
          #create,
          [password],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.PasswordFailure, _i2.Unit>>.value(
                _FakeEither_0<_i5.PasswordFailure, _i2.Unit>(
          this,
          Invocation.method(
            #create,
            [password],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.PasswordFailure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.PasswordFailure, _i2.Unit>> update(
          _i6.Password? password) =>
      (super.noSuchMethod(
        Invocation.method(
          #update,
          [password],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.PasswordFailure, _i2.Unit>>.value(
                _FakeEither_0<_i5.PasswordFailure, _i2.Unit>(
          this,
          Invocation.method(
            #update,
            [password],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.PasswordFailure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.PasswordFailure, _i2.Unit>> delete(
          _i6.Password? password) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [password],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.PasswordFailure, _i2.Unit>>.value(
                _FakeEither_0<_i5.PasswordFailure, _i2.Unit>(
          this,
          Invocation.method(
            #delete,
            [password],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.PasswordFailure, _i2.Unit>>);
}