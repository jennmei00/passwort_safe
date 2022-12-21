part of 'controller_bloc.dart';

@immutable
abstract class ControllerState {}

class ControllerInitial extends ControllerState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ControllerInProgress extends ControllerState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ControllerSuccess extends ControllerState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ControllerFailure extends ControllerState with EquatableMixin {
  final PasswordFailure passwordFailure;
  ControllerFailure({required this.passwordFailure});

  @override
  List<Object?> get props => [];
}
