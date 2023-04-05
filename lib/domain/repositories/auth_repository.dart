import 'package:dartz/dartz.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/core/enums.dart';
import 'package:password_safe/core/failures/auth_failures.dart';
import 'package:password_safe/domain/failures/failures.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';

abstract class AuthRepository {
  Future<void> signOut();
  Future<Either<AuthFailure, Unit>> authenticateWithLocalAuth();
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPassword(
      String email, String password);
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      UserModel user); //String email, String password, String name
  Future<Option<UserModel>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> changePassword(
      {UserModel user, bool forgot, String newPassword});
}
