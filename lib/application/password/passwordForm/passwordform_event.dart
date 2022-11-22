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
  final String? link;
  final IconData? icon;
  final List<Icon>? tags;

  SafePressedEvent({
    required this.title,
    required this.name,
    required this.email,
    required this.passwordText,
    required this.link,
    required this.icon,
    required this.tags,
  });
}
