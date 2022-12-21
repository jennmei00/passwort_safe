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
      print(e);
      return Left(DBFailure());
    }
  }

  @override
  Future<Either<PasswordFailure, Unit>> delete(Password password) async {
    try {
      await dbLocalDatasource.delete('Password',
          where: 'id = "${password.id.value}"');

      return Right(unit);
    } catch (e) {
      print(e);
      return Left(DBFailure());
    }
  }

  @override
  Stream<Either<PasswordFailure, List<Password>>> getAll() async* {
    final mapList = await dbLocalDatasource.getDataa('Password');

    yield* mapList
        .map((event) => right<PasswordFailure, List<Password>>(
            event.map((e) => PasswordModel.fromMap(e).toDomain()).toList()))
        .handleError((e) {
      return Left(DBFailure);
    });
  }

  @override
  Future<Either<PasswordFailure, Unit>> update(Password password) async {
    try {
      await dbLocalDatasource.update(
        'Password',
        PasswordModel.fromDomain(password).toMap(),
        where: 'id = "${password.id.value}"',
      );

      return Right(unit);
    } catch (e) {
      print(e);
      return Left(DBFailure());
    }
  }
}
