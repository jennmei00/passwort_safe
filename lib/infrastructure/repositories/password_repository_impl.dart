import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';
import 'package:password_safe/infrastructure/datasources/db_local_datasource.dart';
import 'package:password_safe/infrastructure/models/password_model.dart';

class PasswordRepositoryImpl implements PasswordRepository {
  final DBLocalDatasource dbLocalDatasource;

  PasswordRepositoryImpl({required this.dbLocalDatasource});

  @override
  Future<Either<PasswordFailure, Unit>> create(Password password) async {
    try {
      final passwordModel = PasswordModel.fromDomain(password);
      await dbLocalDatasource.insert('Password', passwordModel.toMap());

      return Right(unit);
    } catch (e) {
      return Left(DBFailure());
    }
  }

  @override
  Future<Either<PasswordFailure, Unit>> delete(Password password) async {
    try {
      await dbLocalDatasource.delete('Password',
          where: 'id = "${password.id}"');

      return Right(unit);
    } catch (e) {
      return Left(DBFailure());
    }
  }

  @override
  Future<Either<PasswordFailure, List<Password>>> getAll() async {
    try {
      List<Password> passwords = [];

      final mapList = await dbLocalDatasource.getData('Password');

      mapList.forEach((element) {
        passwords.add(PasswordModel.fromMap(element).toDomain());
      });

      return Right(passwords);
    } catch (e) {
      return Left(DBFailure());
    }
  }

  @override
  Future<Either<PasswordFailure, Unit>> update(Password password) async {
    try {
      await dbLocalDatasource.update(
        'Password',
        PasswordModel.fromDomain(password).toMap(),
        where: 'id = "${password.id}"',
      );

      return Right(unit);
    } catch (e) {
      return Left(DBFailure());
    }
  }
}
