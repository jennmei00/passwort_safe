import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:password_safe/domain/repositories/auth_repository.dart';
// import 'package:password_safe/infrastructure/datasources/db_local_auth_datasource.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignOutPressedEvent>((event, emit) async {
      // await authRepository.signOut();
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
      print('Im LoginPressedEvent');
      print(failureOrSuccess);
    });

    on<RegisterPressedEvent>((event, emit) async {
      final failureOrSuccess =
          await authRepository.registerWithPassword(event.user!);
      failureOrSuccess.fold((l) => emit(AuthStateAuthDenied()),
          (r) => emit(AuthStateAuthenticated(userModel: event.user!)));
    });

    // on<LocalAuthPressedEvent>((event, emit) async {
    //   final failureOrSuccess = await authRepository.authenticateWithLocalAuth();
    //   failureOrSuccess.fold((l) => emit(AuthStateTryLogin(userModel: event.user!)),
    //       (r) => emit(AuthStateAuthenticated(userModel: event.user!)));
    // });

    on<ChangePasswordPressedEvent>((event, emit) async {
      // final failureOrSuccess =

      await authRepository.changePassword(newPassword: event.newPassword);

      if (!event.forgot) {
        emit(AuthStateTryLogin(
            userModel: event.user.copyWith(password: event.newPassword)));
      }

      // failureOrSuccess.fold((l) => emit(AuthStateAuthDenied()),
      //     (r) => emit(AuthStateAuthenticated()));
    });

    on<ChangeBioAuthPressedEvent>((event, emit) async {
      // final failureOrSuccess =
      await authRepository.changeBioAuth(bioAuth: event.bioAuth);
      emit(AuthStateTryLogin(
          userModel: event.user.copyWith(bioAuth: event.bioAuth)));
      // failureOrSuccess.fold((l) => emit(AuthStateAuthDenied()),
      //     (r) => emit(AuthStateAuthenticated()));
    });
  }
}
