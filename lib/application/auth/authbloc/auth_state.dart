part of 'auth_bloc.dart';

// enum AuthState {
//   unknown,
//   authenticated,
//   unauthenticated,
//   error,
// }

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthStateAuthenticated extends AuthState {}

class AuthStateUnauthenticated extends AuthState {}

class AuthStateAuthDenied extends AuthState {}

class AuthStateTryLogin extends AuthState {
  final UserModel userModel;
  AuthStateTryLogin({required this.userModel});
}
