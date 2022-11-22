import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  final PasswordRepository passwordRepository;
  StreamSubscription<Either<PasswordFailure, List<Password>>>?
      _passwordStreamSub;

  ObserverBloc({required this.passwordRepository}) : super(ObserverInitial()) {
    on<GetAllEvent>((event, emit) async {
      emit(ObserverLodaing());

      await _passwordStreamSub?.cancel();
      _passwordStreamSub = await passwordRepository.getAll().listen(
          (failureOrPasswords) => add(
              PasswordUpdatedEvent(failureOrPasswords: failureOrPasswords)));

      on<PasswordUpdatedEvent>(((event, emit) {
        event.failureOrPasswords.fold(
            (failure) => ObserverFailure(passwordFailure: failure),
            (password) => emit(ObserverSuccess(passwords: password)));
      }));
    });
  }
}
