part of 'controller_bloc.dart';

@immutable
abstract class ControllerState {}

class ControllerInitial extends ControllerState {}

class ControllerInProgress extends ControllerState {}

class ControllerSuccess extends ControllerState {}

class ControllerFailure extends ControllerState {
  final PasswordFailure passwordFailure;

  ControllerFailure({required this.passwordFailure});
}
