import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';

part 'password_tag_event.dart';
part 'password_tag_state.dart';

class PasswordTagBloc extends Bloc<PasswordTagEvent, PasswordTagState> {
  final PasswordRepository passwordRepository;

  PasswordTagBloc({required this.passwordRepository})
      : super(PasswordTagState.initial()) {
    on<InitializePassword>((event, emit) {
      if (event.password != null) {
        emit(state.copyWith(password: event.password));
      } else {
        emit(state);
      }
    });

    on<TagPressedEvent>((event, emit) async {
      Either<PasswordFailure, Unit>? failureOrSuccess;

      emit(state.copyWith(
          isSaving: true,
          failureOrSuccessOption: none(),
          tagAdded: event.addTag));

      Password editedPassword = state.password;
      switch (event.tag) {
        case 1:
          editedPassword = state.password.copyWith(favTag: state.tagAdded);
          break;
        case 2:
          editedPassword = state.password.copyWith(emailTag: state.tagAdded);
          break;
        case 3:
          editedPassword = state.password.copyWith(webTag: state.tagAdded);
          break;
        default:
      }

      failureOrSuccess = await passwordRepository.update(editedPassword);

      emit(state.copyWith(
          isSaving: false,
          failureOrSuccessOption: optionOf(failureOrSuccess),
          password: editedPassword));
    });
  }
}
