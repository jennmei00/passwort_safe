import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_safe/core/failures/auth_failures.dart';
import 'package:password_safe/domain/entities/user.dart';
import 'package:password_safe/domain/repositories/auth_repository.dart';
import 'package:password_safe/infrastructure/datasources/db_local_auth_datasource.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DBLocalAuthDatasource dbLocalAuthDatasource;
  final LocalAuthentication _localAuth = LocalAuthentication();
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(
      {required this.firebaseAuth, required this.dbLocalAuthDatasource});

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
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // final user = User.fromMap(await dbLocalAuthDatasource.getUser());
      // if (user.password == password) {
      return Right(unit);
      // } else {
      //   return Left(WrongPasswordFailure());
      // }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'wrong-password' || e.code == "user-not-found") {
        return Left(WrongPasswordFailure());
      } else {
        return Left(LoginFailure());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      UserModel user) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password!);
      await dbLocalAuthDatasource.addUser(user.toMap());
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == "email-alreade-in-use") {
        return Left(EmailAlreadyInUseFailure());
      } else {
        return Left(RegisterFailure());
      }
    }
  }

  @override
  Future<void> signOut() => Future.wait([
        firebaseAuth.signOut(),
        dbLocalAuthDatasource.deleteUser(),
      ]);

  @override
  Future<Option<UserModel>> getSignedInUser() async {
    final userMap = await dbLocalAuthDatasource.getUser();
    if (userMap.isEmpty) {
      return optionOf(null);
    } else {
      return optionOf(UserModel.fromMap(userMap));
    }

    // return firebaseAuth.currentUser != null
    //     ? optionOf(UserModel(
    //         name: 'TestName',
    //         email: firebaseAuth.currentUser!.email!,
    //         password: null,
    //       ))
    //     : optionOf(null);
  }
}
