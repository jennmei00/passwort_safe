import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/core/enums.dart';
import 'package:password_safe/core/failures/auth_failures.dart';
import 'package:password_safe/domain/entities/user.dart';
import 'package:password_safe/domain/failures/failures.dart';
import 'package:password_safe/domain/repositories/auth_repository.dart';
import 'package:password_safe/infrastructure/datasources/db_local_auth_datasource.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // await dbLocalAuthDatasource.deleteDatabase();
      final user = UserModel.fromMap(await dbLocalAuthDatasource.getUser());
      print('PASSWORD');
      print(user.password);
      // UserModel? user;
      // final prefs = await SharedPreferences.getInstance();
      // user = UserModel(
      //   name: prefs.getString('username')!,
      //   email: prefs.getString('email')!,
      //   password: prefs.getString('password')!,
      //   securityQuestionIndex: prefs.getInt('securityQuestion') ?? 0,
      //   securityAnswer: prefs.getString('securityAnswer'),
      // );

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
      // final prefs = await SharedPreferences.getInstance();

      // prefs.setString('username', user.name);
      // prefs.setString('email', user.email);
      // prefs.setString('password', user.password!);
      // prefs.setInt('securityQuestion', user.securityQuestionIndex);
      // prefs.setString('securityAnswer', user.securityAnswer!);

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
      await dbLocalAuthDatasource.changePassword(u.toMap());
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString('password', newPassword);
      return Right(unit);
    } catch (e) {
      print(e);
      return Left(PasswordChangeFailure());
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
      await dbLocalAuthDatasource.changeBioAuth(u.toMap());
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString('password', newPassword);

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
    // await dbLocalAuthDatasource.deleteDatabase();
    final userMap = await dbLocalAuthDatasource.getUser();
    // final prefs = await SharedPreferences.getInstance();

    // final username = prefs.getString('username');
    // final email = prefs.getString('email');
    // final password = prefs.getString('password');
    // print('PASSWORT;');
    // print(password);
    // final sq = prefs.getInt('securityQuestion');
    // final sa = prefs.getString('securityAnswer');

    // if (username != null && email != null) {
    //   return optionOf(UserModel(
    //       name: username,
    //       email: email,
    //       password: password,
    //       securityQuestionIndex: sq ?? 0,
    //       securityAnswer: sa));
    // } else {
    //   return optionOf(null);
    // }

    if (userMap.isEmpty) {
      return optionOf(null);
    } else {
      return optionOf(UserModel.fromMap(userMap));
    }
  }
}
