import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/password.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  ObserverBloc() : super(ObserverInitial()) {
    on<ObserverEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
