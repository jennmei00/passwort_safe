import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:password_safe/core/failures/auth_failures.dart';
import 'package:password_safe/domain/entities/user.dart';
import 'package:password_safe/domain/failures/failures.dart';
import 'package:password_safe/domain/repositories/auth_repository.dart';
import 'package:password_safe/infrastructure/datasources/db_local_auth_datasource.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:random_password_generator/random_password_generator.dart';

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
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      UserModel user) async {
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
      {UserModel? user, forgot = false, String newPassword = ''}) async {
    try {
      String password = user!.password!;
      if (forgot) {
        password = RandomPasswordGenerator()
            .randomPassword(letters: true, numbers: true);
        print(password);

        final emailJStudios = 'jstudios0096@gmail.com';
        final token = '';

        final smptServer = gmailSaslXoauth2(emailJStudios, token);

        final message = Message()
          ..from = Address(emailJStudios, 'Jstudios+')
          ..recipients = [user.email]
          ..subject = 'Passwort zurückgesetzt'
          ..text =
              'Dein Passwort wurde erfolgreich zurückgesetzt.\nNeues Passwort: $password\nDu kannst das Passwort in den Einstellungen ändern.';
        try {
          await send(message, smptServer);
        } on MailerException catch (e) {
          print(e);
        }
        // final Email email = Email(
        //     subject: 'Passwort zurückgesetzt',
        //     recipients: [user.email],
        //     body:
        //         'Dein Passwort wurde erfolgreich zurückgesetzt.\nNeues Passwort: $password\nDu kannst das Passwort in den Einstellungen ändern.');

        // await FlutterEmailSender.send(email);
      } else {
        password = newPassword;
      }
      UserModel u =
          UserModel(name: user.name, email: user.email, password: password);
      await dbLocalAuthDatasource.changePassword(u.toMap());

      return Right(unit);
    } catch (e) {
      print(e);
      return Left(PasswordChangeFailure());
    }
  }

  @override
  Future<void> signOut() => Future.wait([
        // firebaseAuth.signOut(),
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
