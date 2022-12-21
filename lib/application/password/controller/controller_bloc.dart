import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';

part 'controller_event.dart';
part 'controller_state.dart';

class ControllerBloc extends Bloc<ControllerEvent, ControllerState> {
  final PasswordRepository passwordRepository;

  ControllerBloc({required this.passwordRepository})
      : super(ControllerInitial()) {
    on<DeletePasswordEvent>((event, emit) async {
      emit(ControllerInProgress());
      final failureOrSuccess = await passwordRepository.delete(event.password);
      failureOrSuccess.fold(
          (failure) => emit(ControllerFailure(passwordFailure: failure)),
          (_) => emit(ControllerSuccess()));
    });

    on<UpdatePasswordEvent>((event, emit) async {
      emit(ControllerInProgress());
      final failureOrSuccess = await passwordRepository.update(event.password);
      failureOrSuccess.fold(
          (failure) => emit(ControllerFailure(passwordFailure: failure)),
          (_) => emit(ControllerSuccess()));
    });
  }
}
