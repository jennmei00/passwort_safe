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
        right(unit);
      } else {
        left(LocalAuthFailure());
      }
    } catch (e) {
      print('Error authenticating with local auth: $e');
      return left(LocalAuthFailure());
    }
    return left(LocalAuthFailure());
  }

  @override
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPassword(
      String password, String email) async {
    try {
      // await dbLocalAuthDatasource.deleteDatabase();
      // final user2 = UserModel.fromMap(await dbLocalAuthDatasource.getUser());
      UserModel? user;
      final prefs = await SharedPreferences.getInstance();
      user = UserModel(
        name: prefs.getString('username')!,
        email: prefs.getString('email')!,
        password: prefs.getString('password')!,
        securityQuestionIndex: prefs.getInt('securityQuestion') ?? 0,
        securityAnswer: prefs.getString('securityAnswer'),
      );

      // await dbLocalAuthDatasource.openDatabase();
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
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('username', user.name);
      prefs.setString('email', user.email);
      prefs.setString('password', user.password!);
      prefs.setInt('securityQuestion', user.securityQuestionIndex);
      prefs.setString('securityAnswer', user.securityAnswer!);

      // await dbLocalAuthDatasource.addUser(user.toMap());
      return Right(unit);
    } catch (e) {
      print(e);
      return Left(RegisterFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> changePassword(
      {UserModel? user, bool forgot = false, String newPassword = ''}) async {
    try {
      // String password = user!.password!;
      // UserModel u = UserModel(
      //   name: user.name,
      //   email: user.email,
      //   password: password,
      //   securityQuestionIndex: user.securityQuestionIndex,
      //   securityAnswer: user.securityAnswer,
      // );
      // // await dbLocalAuthDatasource.changePassword(u.toMap());
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('password', newPassword);

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
    // final userMap = await dbLocalAuthDatasource.getUser();
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    print('PASSWORT;');
    print(password);
    final sq = prefs.getInt('securityQuestion');
    final sa = prefs.getString('securityAnswer');

    if (username != null && email != null) {
      return optionOf(UserModel(
          name: username,
          email: email,
          password: password,
          securityQuestionIndex: sq ?? 0,
          securityAnswer: sa));
    } else {
      return optionOf(null);
    }

    // if (userMap.isEmpty) {
    //   return optionOf(null);
    // } else {
    //   return optionOf(UserModel.fromMap(userMap));
    // }
    // return optionOf(null);

    // return firebaseAuth.currentUser != null
    //     ? optionOf(UserModel(
    //         name: 'TestName',
    //         email: firebaseAuth.currentUser!.email!,
    //         password: null,
    //       ))
    //     : optionOf(null);
  }
}
