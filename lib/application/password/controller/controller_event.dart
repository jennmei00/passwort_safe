part of 'controller_bloc.dart';

@immutable
abstract class ControllerEvent {}

class DeletePasswordEvent extends ControllerEvent {
  final Password password;

  DeletePasswordEvent({required this.password});
}

class UpdatePasswordEvent extends ControllerEvent {
  final Password password;

  UpdatePasswordEvent({required this.password});
}
