import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';

part 'passwordform_event.dart';
part 'passwordform_state.dart';

class PasswordformBloc extends Bloc<PasswordformEvent, PasswordformState> {
  final PasswordRepository passwordRepository;

  PasswordformBloc({required this.passwordRepository})
      : super(PasswordformState.initial()) {
    on<InitializePasswordDetailContainer>((event, emit) {
      if (event.password != null) {
        emit(state.copyWith(password: event.password, isEditing: true));
      } else {
        emit(state);
      }
    });

    on<SafePressedEvent>((event, emit) async {
      Either<PasswordFailure, Unit>? failureOrSuccess;

      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

      if (event.passwordText != null &&
          event.title != null &&
          event.name != null &&
          event.email != null &&
          event.icon != null &&
          event.info != null) {
        final Password editedPassword = state.password.copyWith(
          password: event.passwordText,
          title: event.title,
          name: event.name,
          email: event.email,
          info: event.info,
          icon: event.icon,
        );

        if (state.isEditing) {
          failureOrSuccess = await passwordRepository.update(editedPassword);
        } else {
          failureOrSuccess = await passwordRepository.create(editedPassword);
        }
      }

      emit(state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          failureOrSuccessOption: optionOf(failureOrSuccess)));
    });
  }
}
