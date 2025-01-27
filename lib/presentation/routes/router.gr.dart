// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/cupertino.dart' as _i11;
import 'package:flutter/material.dart' as _i13;
import 'package:password_safe/infrastructure/models/user_model.dart' as _i12;
import 'package:password_safe/presentation/passwords/password_overview_page.dart'
    as _i5;
import 'package:password_safe/presentation/settings/change_passwort_page.dart'
    as _i1;
import 'package:password_safe/presentation/settings/change_security_question_page.dart'
    as _i2;
import 'package:password_safe/presentation/settings/settings_page.dart' as _i7;
import 'package:password_safe/presentation/signup/forgot_password_page.dart'
    as _i3;
import 'package:password_safe/presentation/signup/login_page.dart' as _i4;
import 'package:password_safe/presentation/signup/security_question_page.dart'
    as _i6;
import 'package:password_safe/presentation/signup/signup_page.dart' as _i8;
import 'package:password_safe/presentation/splash/splash_page.dart' as _i9;

/// generated route for
/// [_i1.ChangePasswordPage]
class ChangePasswordRoute extends _i10.PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    _i11.Key? key,
    required _i12.UserModel user,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         ChangePasswordRoute.name,
         args: ChangePasswordRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'ChangePasswordRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangePasswordRouteArgs>();
      return _i1.ChangePasswordPage(key: args.key, user: args.user);
    },
  );
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key, required this.user});

  final _i11.Key? key;

  final _i12.UserModel user;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i2.ChangeSecurityQuestionPage]
class ChangeSecurityQuestionRoute
    extends _i10.PageRouteInfo<ChangeSecurityQuestionRouteArgs> {
  ChangeSecurityQuestionRoute({
    _i11.Key? key,
    required _i12.UserModel user,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         ChangeSecurityQuestionRoute.name,
         args: ChangeSecurityQuestionRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'ChangeSecurityQuestionRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangeSecurityQuestionRouteArgs>();
      return _i2.ChangeSecurityQuestionPage(key: args.key, user: args.user);
    },
  );
}

class ChangeSecurityQuestionRouteArgs {
  const ChangeSecurityQuestionRouteArgs({this.key, required this.user});

  final _i11.Key? key;

  final _i12.UserModel user;

  @override
  String toString() {
    return 'ChangeSecurityQuestionRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i3.ForgotPasswordPage]
class ForgotPasswordRoute extends _i10.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    _i13.Key? key,
    required _i12.UserModel user,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         ForgotPasswordRoute.name,
         args: ForgotPasswordRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'ForgotPasswordRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>();
      return _i3.ForgotPasswordPage(key: args.key, user: args.user);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key, required this.user});

  final _i13.Key? key;

  final _i12.UserModel user;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i13.Key? key,
    required _i12.UserModel user,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>();
      return _i4.LoginPage(key: args.key, user: args.user);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.user});

  final _i13.Key? key;

  final _i12.UserModel user;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i5.PasswordOverViewPage]
class PasswordOverViewRoute
    extends _i10.PageRouteInfo<PasswordOverViewRouteArgs> {
  PasswordOverViewRoute({
    _i13.Key? key,
    required _i12.UserModel user,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         PasswordOverViewRoute.name,
         args: PasswordOverViewRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'PasswordOverViewRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PasswordOverViewRouteArgs>();
      return _i5.PasswordOverViewPage(key: args.key, user: args.user);
    },
  );
}

class PasswordOverViewRouteArgs {
  const PasswordOverViewRouteArgs({this.key, required this.user});

  final _i13.Key? key;

  final _i12.UserModel user;

  @override
  String toString() {
    return 'PasswordOverViewRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i6.SecurityQuestionPage]
class SecurityQuestionRoute
    extends _i10.PageRouteInfo<SecurityQuestionRouteArgs> {
  SecurityQuestionRoute({
    _i13.Key? key,
    required _i12.UserModel user,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         SecurityQuestionRoute.name,
         args: SecurityQuestionRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'SecurityQuestionRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SecurityQuestionRouteArgs>();
      return _i6.SecurityQuestionPage(key: args.key, user: args.user);
    },
  );
}

class SecurityQuestionRouteArgs {
  const SecurityQuestionRouteArgs({this.key, required this.user});

  final _i13.Key? key;

  final _i12.UserModel user;

  @override
  String toString() {
    return 'SecurityQuestionRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i7.SettingsPage]
class SettingsRoute extends _i10.PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    _i11.Key? key,
    required _i12.UserModel user,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         SettingsRoute.name,
         args: SettingsRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'SettingsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettingsRouteArgs>();
      return _i7.SettingsPage(key: args.key, user: args.user);
    },
  );
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key, required this.user});

  final _i11.Key? key;

  final _i12.UserModel user;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i8.SignUpPage]
class SignUpRoute extends _i10.PageRouteInfo<void> {
  const SignUpRoute({List<_i10.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SignUpPage();
    },
  );
}

/// generated route for
/// [_i9.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashPage();
    },
  );
}
