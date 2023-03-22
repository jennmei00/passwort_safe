part of 'auth_bloc.dart';

// enum AuthEvent {
//   loginWithLocalAuth,
// }

abstract class AuthEvent {}

class SignOutPressedEvent extends AuthEvent {}

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

class LocalAuthPressedEvent extends AuthEvent {
  final UserModel? user;

  LocalAuthPressedEvent({required this.user});
}
