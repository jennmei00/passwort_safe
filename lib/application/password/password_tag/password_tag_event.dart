part of 'password_tag_bloc.dart';

@immutable
abstract class PasswordTagEvent {}

class InitializePassword extends PasswordTagEvent {
  final Password? password;
  InitializePassword({required this.password});
}

class TagPressedEvent extends PasswordTagEvent {
  final int tag;
  final bool addTag;

  TagPressedEvent({required this.tag, required this.addTag});
}
