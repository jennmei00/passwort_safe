part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignOutPressedEvent extends AuthEvent {
  SignOutPressedEvent();
}

class AuthCheckRequestedEvent extends AuthEvent {}

class RegisterPressedEvent extends AuthEvent {
  final UserModel? user;

  RegisterPressedEvent({required this.user});
}

class LoginPressedEvent extends AuthEvent {
  final String? password;
  final UserModel? user;

  LoginPressedEvent({required this.password, required this.user});
}

class DeleteAccountPressedEvent extends AuthEvent {}

class ChangePasswordPressedEvent extends AuthEvent {
  final UserModel user;
  final bool forgot;
  final String newPassword;

  ChangePasswordPressedEvent({
    required this.forgot,
    this.newPassword = '',
    required this.user,
  });
}

class ChangeSecurityQuestionPressedEvent extends AuthEvent {
  final UserModel user;
  final String newAnswer;
  final int newQuestionIndex;

  ChangeSecurityQuestionPressedEvent({
    required this.newAnswer,
    required this.newQuestionIndex,
    required this.user,
  });
}

class ChangeNamePressedEvent extends AuthEvent {
  final UserModel user;
  final String newName;

  ChangeNamePressedEvent({
    required this.user,
    required this.newName,
  });
}

class ChangeBioAuthPressedEvent extends AuthEvent {
  final bool bioAuth;
  final UserModel user;

  ChangeBioAuthPressedEvent({
    this.bioAuth = false,
    required this.user,
  });
}

class AuthLoggedOutEvent extends AuthEvent {
  final UserModel user;

  AuthLoggedOutEvent({
    required this.user,
  });
}
