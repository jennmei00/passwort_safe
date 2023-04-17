part of 'passwordform_bloc.dart';

@immutable
abstract class PasswordformEvent {}

class InitializePasswordDetailContainer extends PasswordformEvent {
  final Password? password;
  InitializePasswordDetailContainer({required this.password});
}

class SafePressedEvent extends PasswordformEvent {
  final String? title;
  final String? name;
  final String? email;
  final String? passwordText;
  final String? info;
  final IconData? icon;

  SafePressedEvent({
    required this.title,
    required this.name,
    required this.email,
    required this.passwordText,
    required this.info,
    required this.icon,
  });
}
