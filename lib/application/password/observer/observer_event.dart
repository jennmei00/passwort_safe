part of 'observer_bloc.dart';

@immutable
abstract class ObserverEvent {}

class GetAllEvent extends ObserverEvent {
  GetAllEvent();
}

class PasswordUpdatedEvent extends ObserverEvent {
  final Either<PasswordFailure, List<Password>> failureOrPasswords;

  PasswordUpdatedEvent({required this.failureOrPasswords});
}
