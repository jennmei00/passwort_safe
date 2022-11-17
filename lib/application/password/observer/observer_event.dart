part of 'observer_bloc.dart';

@immutable
abstract class ObserverEvent {}

class ObserveAllEvent extends ObserverEvent {}

class PasswordUpdatedEvent extends ObserverEvent {
  final Either<PasswordFailure, List<Password>> failureOrPAsswords;

  PasswordUpdatedEvent({required this.failureOrPAsswords});
}
