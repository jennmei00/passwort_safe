import 'package:password_safe/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:password_safe/domain/repositories/theme_repository.dart';
import 'package:password_safe/infrastructure/datasources/theme_local_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDatasource themeLocalDatasource;

  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<Either<Failure, bool>> getThemeMode() async {
    try {
      final themeMode = await themeLocalDatasource.getCachedThemeData();

      return Right(themeMode);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> setThemeMode({required bool mode}) {
    return themeLocalDatasource.chacheThemeData(mode: mode);
  }
}
