import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_safe/core/failures/auth_failures.dart';
import 'package:password_safe/domain/repositories/auth_repository.dart';
import 'package:password_safe/infrastructure/datasources/db_local_auth_datasource.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DBLocalAuthDatasource dbLocalAuthDatasource;
  final LocalAuthentication _localAuth = LocalAuthentication();

  AuthRepositoryImpl({required this.dbLocalAuthDatasource});

  @override
  Future<Either<AuthFailure, Unit>> authenticateWithLocalAuth() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuth.authenticate(
        localizedReason: 'Bitte authentifizieren um fortzufahren',
        options: AuthenticationOptions(
            biometricOnly: false, useErrorDialogs: true, stickyAuth: true),
      );
      if (isAuthorized) {
        await dbLocalAuthDatasource.openDatabase();
        return right(unit);
      } else {
        return left(LocalAuthFailure());
      }
    } catch (e) {
       print('Error authenticating with local auth: $e');
      return left(LocalAuthFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> loginWithPassword(String password) async {
    try {
      final user = UserModel.fromMap(await dbLocalAuthDatasource.getUser());
      if (user.password == password) {
        return Right(unit);
      } else {
        return Left(WrongPasswordFailure());
      }
    } catch (e) {
      print(e);
      return Left(LoginFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithPassword(UserModel user) async {
    try {
      await dbLocalAuthDatasource.addUser(user.toMap());
      return Right(unit);
    } catch (e) {
      print(e);
      return Left(RegisterFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> changePassword(
      {String newPassword = ''}) async {
    try {
      final user = UserModel.fromMap(await dbLocalAuthDatasource.getUser());
      UserModel u = UserModel(
        name: user.name,
        password: newPassword,
        securityQuestionIndex: user.securityQuestionIndex,
        securityAnswer: user.securityAnswer,
        bioAuth: user.bioAuth,
      );
      await dbLocalAuthDatasource.changeUserData(u.toMap());
      return Right(unit);
    } catch (e) {
      print(e);
      return Left(PasswordChangeFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> changeName({String newName = ''}) async {
    try {
      final user = UserModel.fromMap(await dbLocalAuthDatasource.getUser());
      UserModel u = UserModel(
        name: newName,
        password: user.password,
        securityQuestionIndex: user.securityQuestionIndex,
        securityAnswer: user.securityAnswer,
        bioAuth: user.bioAuth,
      );
      await dbLocalAuthDatasource.changeUserData(u.toMap());
      return Right(unit);
    } catch (e) {
      print(e);
      return Left(NameChangeFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> changeSecurityQuestion(
      {required String newAnswer, required int newQuestionIndex}) async {
    try {
      final user = UserModel.fromMap(await dbLocalAuthDatasource.getUser());
      UserModel u = user.copyWith(
          securityAnswer: newAnswer, securityQuestionIndex: newQuestionIndex);

      await dbLocalAuthDatasource.changeUserData(u.toMap());
      return Right(unit);
    } catch (e) {
      print(e);
      return Left(SecurityQuestionChangeFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> changeBioAuth(
      {bool bioAuth = false}) async {
    try {
      final user = UserModel.fromMap(await dbLocalAuthDatasource.getUser());
      UserModel u = UserModel(
        name: user.name,
        password: user.password,
        securityQuestionIndex: user.securityQuestionIndex,
        securityAnswer: user.securityAnswer,
        bioAuth: bioAuth,
      );
      await dbLocalAuthDatasource.changeUserData(u.toMap());
      return Right(unit);
    } catch (e) {
      print(e);
      return Left(PasswordChangeFailure());
    }
  }

  @override
  Future<void> signOut() => Future.wait([
        // firebaseAuth.signOut(),
        // dbLocalAuthDatasource.deleteUser(),
      ]);

  @override
  Future<Option<UserModel>> getSignedInUser() async {
    print('ingetsigneIn user');
    final userMap = await dbLocalAuthDatasource.getUser();

    if (userMap.isEmpty) {
      return optionOf(null);
    } else {
      return optionOf(UserModel.fromMap(userMap));
    }
  }

  @override
  Future<void> deleteAccount() async {
    await dbLocalAuthDatasource.deleteDatabase();
  }
}
