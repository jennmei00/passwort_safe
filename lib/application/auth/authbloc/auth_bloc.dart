import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_safe/domain/repositories/auth_repository.dart';
import 'package:password_safe/infrastructure/datasources/db_local_auth_datasource.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignOutPressedEvent>((event, emit) async {
      await authRepository.signOut();
      emit(AuthStateUnauthenticated());
    });

    on<AuthCheckRequestedEvent>((event, emit) async {
      final userOption = await authRepository.getSignedInUser();
      userOption.fold(() => emit(AuthStateUnauthenticated()),
          (userModel) => emit(AuthStateTryLogin(userModel: userModel)));
    });

    on<LoginPressedEvent>((event, emit) async {
      final failureOrSuccess = await authRepository.loginWithEmailAndPassword(
          event.password!, event.user!.email);
      failureOrSuccess.fold((l) => null,
          (r) => emit(AuthStateAuthenticated()));
    });

    on<RegisterPressedEvent>((event, emit) async {
      final failureOrSuccess =
          await authRepository.registerWithEmailAndPassword(event.user!);
      failureOrSuccess.fold((l) => emit(AuthStateAuthDenied()),
          (r) => emit(AuthStateAuthenticated()));
    });

    on<LocalAuthPressedEvent>((event, emit) async {
      final failureOrSuccess = await authRepository.authenticateWithLocalAuth();
      failureOrSuccess.fold((l) => emit(AuthStateAuthDenied()),
          (r) => emit(AuthStateAuthenticated()));
    });
  }
}
