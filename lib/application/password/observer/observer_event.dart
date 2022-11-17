part of 'observer_bloc.dart';

@immutable
abstract class ObserverEvent {}

class GetAllEvent extends ObserverEvent {
  final Either<PasswordFailure, List<Password>> failureOrPasswords;

  GetAllEvent({required this.failureOrPasswords});
}

// class PasswordUpdatedEvent extends ObserverEvent {
//   final Either<PasswordFailure, List<Password>> failureOrPasswords;

//   PasswordUpdatedEvent({required this.failureOrPasswords});
// }
