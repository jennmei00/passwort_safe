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

  ObserverBloc({required this.passwordRepository}) : super(ObserverInitial()) {
    on<GetAllEvent>((event, emit) {
      emit(ObserverLodaing());

      event.failureOrPasswords.fold(
          (failure) => emit(ObserverFailure(passwordFailure: failure)),
          (password) => emit(ObserverSuccess(passwords: password)));
    });

    // on<PasswordUpdatedEvent>(((event, emit) {
    //   event.failureOrPAsswords.fold(
    //       (failure) => ObserverFailure(passwordFailure: failure),
    //       (password) => emit(ObserverSuccess(passwords: password)));
    // }));
  }
}
