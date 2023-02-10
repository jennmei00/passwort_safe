part of 'observer_bloc.dart';

@immutable
abstract class ObserverState {}

class ObserverInitial extends ObserverState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ObserverLodaing extends ObserverState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ObserverFailure extends ObserverState with EquatableMixin {
  final PasswordFailure passwordFailure;
  ObserverFailure({required this.passwordFailure});

  @override
  List<Object?> get props => [passwordFailure];
}

class ObserverSuccess extends ObserverState with EquatableMixin {
  final List<Password> passwords;
  ObserverSuccess({required this.passwords});
  
  @override
  List<Object?> get props => [passwords];

}
