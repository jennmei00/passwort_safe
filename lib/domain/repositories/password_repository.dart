import 'package:dartz/dartz.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/password.dart';

abstract class PasswordRepository {
  Future<Either<PasswordFailure, List<Password>>> getAll();
  // Future<Either<PasswordFailure, Password>> getOne(String id);
  Future<Either<PasswordFailure, Unit>> create(Password password);
  Future<Either<PasswordFailure, Unit>> update(Password password);
  Future<Either<PasswordFailure, Unit>> delete(Password password);
}
