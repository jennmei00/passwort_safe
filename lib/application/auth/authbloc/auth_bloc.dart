import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:password_safe/domain/repositories/auth_repository.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignOutPressedEvent>((event, emit) async {
      final userOption = await authRepository.getSignedInUser();
      final user = userOption.fold(() => null, (u) => u);

      emit(AuthStateTryLogin(userModel: user!));
    });

    on<AuthCheckRequestedEvent>((event, emit) async {
      final userOption = await authRepository.getSignedInUser();
      userOption.fold(() => emit(AuthStateUnauthenticated()),
          (userModel) => emit(AuthStateTryLogin(userModel: userModel)));
    });

    on<LoginPressedEvent>((event, emit) async {
      final failureOrSuccess =
          await authRepository.loginWithPassword(event.password!);
      failureOrSuccess.fold((l) => null,
          (r) => emit(AuthStateAuthenticated(userModel: event.user!)));
    });

    on<RegisterPressedEvent>((event, emit) async {
      final failureOrSuccess =
          await authRepository.registerWithPassword(event.user!);
      failureOrSuccess.fold((l) => emit(AuthStateAuthDenied()),
          (r) => emit(AuthStateAuthenticated(userModel: event.user!)));
    });

    on<ChangePasswordPressedEvent>((event, emit) async {
      await authRepository.changePassword(newPassword: event.newPassword);

      if (!event.forgot) {
        emit(AuthStateTryLogin(
            userModel: event.user.copyWith(password: event.newPassword)));
      }
    });

    on<ChangeNamePressedEvent>((event, emit) async {
      await authRepository.changeName(newName: event.newName);

      emit(AuthStateTryLogin(
          userModel: event.user.copyWith(name: event.newName)));
    });

    on<ChangeSecurityQuestionPressedEvent>((event, emit) async {
      await authRepository.changeSecurityQuestion(
          newAnswer: event.newAnswer, newQuestionIndex: event.newQuestionIndex);

      emit(AuthStateTryLogin(
          userModel: event.user.copyWith(
              securityAnswer: event.newAnswer,
              securityQuestionIndex: event.newQuestionIndex)));
    });

    on<ChangeBioAuthPressedEvent>((event, emit) async {
      await authRepository.changeBioAuth(bioAuth: event.bioAuth);
      emit(AuthStateTryLogin(
          userModel: event.user.copyWith(bioAuth: event.bioAuth)));
    });

    on<DeleteAccountPressedEvent>((event, emit) async {
      await authRepository.deleteAccount();
      emit(AuthStateUnauthenticated());
    });

    on<AuthLoggedOutEvent>((event, emit) async {
      emit(AuthStateTryLogin(userModel: event.user));
    });
  }
}
