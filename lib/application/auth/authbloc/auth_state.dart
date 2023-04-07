part of 'auth_bloc.dart';

// enum AuthState {
//   unknown,
//   authenticated,
//   unauthenticated,
//   error,
// }

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthStateAuthenticated extends AuthState {
  final UserModel userModel;

  AuthStateAuthenticated({ required this.userModel});

}

class AuthStateUnauthenticated extends AuthState {}

class AuthStateAuthDenied extends AuthState {}

class AuthStateTryLogin extends AuthState {
  final UserModel userModel;
  AuthStateTryLogin({required this.userModel});
}
