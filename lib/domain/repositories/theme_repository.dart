import 'package:dartz/dartz.dart';
import 'package:password_safe/domain/repositories/failures/failures.dart';

abstract class ThemeRepository {
  Future<Either<Failure, bool>> getThemeMode();

  Future<void> setThemeMode({required bool mode});
}