part of 'observer_bloc.dart';

@immutable
abstract class ObserverState {}

class ObserverInitial extends ObserverState {}

class ObserverLodaing extends ObserverState {}

class ObserverFailure extends ObserverState {
  final PasswordFailure passwordFailure;
  ObserverFailure({required this.passwordFailure});
}

class ObserverSuccess extends ObserverState {
  final List<Password> passwords;
  ObserverSuccess({required this.passwords});
}
