// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../../infrastructure/models/user_model.dart' as _i11;
import '../passwords/password_overview_page.dart' as _i8;
import '../settings/change_passwort_page.dart' as _i7;
import '../settings/settings_page.dart' as _i6;
import '../signup/forgot_password_page.dart' as _i3;
import '../signup/login_page.dart' as _i5;
import '../signup/security_question_page.dart' as _i4;
import '../signup/signup_page.dart' as _i2;
import '../splash/splash_page.dart' as _i1;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignUpPage(),
      );
    },
    ForgotPasswordPageRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.ForgotPasswordPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    SecurityQuestionPageRoute.name: (routeData) {
      final args = routeData.argsAs<SecurityQuestionPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.SecurityQuestionPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.LoginPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    SettingsPageRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.SettingsPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    ChangePasswordPageRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.ChangePasswordPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    PasswordOverViewPageRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordOverViewPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.PasswordOverViewPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          SplashPageRoute.name,
          path: '/',
        ),
        _i9.RouteConfig(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        ),
        _i9.RouteConfig(
          ForgotPasswordPageRoute.name,
          path: '/forgot-password-page',
        ),
        _i9.RouteConfig(
          SecurityQuestionPageRoute.name,
          path: '/security-question-page',
        ),
        _i9.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i9.RouteConfig(
          SettingsPageRoute.name,
          path: '/settings-page',
        ),
        _i9.RouteConfig(
          ChangePasswordPageRoute.name,
          path: '/change-password-page',
        ),
        _i9.RouteConfig(
          PasswordOverViewPageRoute.name,
          path: '/password-over-view-page',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i9.PageRouteInfo<void> {
  const SplashPageRoute()
      : super(
          SplashPageRoute.name,
          path: '/',
        );

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.SignUpPage]
class SignUpPageRoute extends _i9.PageRouteInfo<void> {
  const SignUpPageRoute()
      : super(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        );

  static const String name = 'SignUpPageRoute';
}

/// generated route for
/// [_i3.ForgotPasswordPage]
class ForgotPasswordPageRoute
    extends _i9.PageRouteInfo<ForgotPasswordPageRouteArgs> {
  ForgotPasswordPageRoute({
    _i10.Key? key,
    required _i11.UserModel user,
  }) : super(
          ForgotPasswordPageRoute.name,
          path: '/forgot-password-page',
          args: ForgotPasswordPageRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'ForgotPasswordPageRoute';
}

class ForgotPasswordPageRouteArgs {
  const ForgotPasswordPageRouteArgs({
    this.key,
    required this.user,
  });

  final _i10.Key? key;

  final _i11.UserModel user;

  @override
  String toString() {
    return 'ForgotPasswordPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i4.SecurityQuestionPage]
class SecurityQuestionPageRoute
    extends _i9.PageRouteInfo<SecurityQuestionPageRouteArgs> {
  SecurityQuestionPageRoute({
    _i10.Key? key,
    required _i11.UserModel user,
  }) : super(
          SecurityQuestionPageRoute.name,
          path: '/security-question-page',
          args: SecurityQuestionPageRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'SecurityQuestionPageRoute';
}

class SecurityQuestionPageRouteArgs {
  const SecurityQuestionPageRouteArgs({
    this.key,
    required this.user,
  });

  final _i10.Key? key;

  final _i11.UserModel user;

  @override
  String toString() {
    return 'SecurityQuestionPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i5.LoginPage]
class LoginPageRoute extends _i9.PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({
    _i10.Key? key,
    required _i11.UserModel user,
  }) : super(
          LoginPageRoute.name,
          path: '/login-page',
          args: LoginPageRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'LoginPageRoute';
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({
    this.key,
    required this.user,
  });

  final _i10.Key? key;

  final _i11.UserModel user;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsPageRoute extends _i9.PageRouteInfo<SettingsPageRouteArgs> {
  SettingsPageRoute({
    _i10.Key? key,
    required _i11.UserModel user,
  }) : super(
          SettingsPageRoute.name,
          path: '/settings-page',
          args: SettingsPageRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'SettingsPageRoute';
}

class SettingsPageRouteArgs {
  const SettingsPageRouteArgs({
    this.key,
    required this.user,
  });

  final _i10.Key? key;

  final _i11.UserModel user;

  @override
  String toString() {
    return 'SettingsPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i7.ChangePasswordPage]
class ChangePasswordPageRoute
    extends _i9.PageRouteInfo<ChangePasswordPageRouteArgs> {
  ChangePasswordPageRoute({
    _i10.Key? key,
    required _i11.UserModel user,
  }) : super(
          ChangePasswordPageRoute.name,
          path: '/change-password-page',
          args: ChangePasswordPageRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'ChangePasswordPageRoute';
}

class ChangePasswordPageRouteArgs {
  const ChangePasswordPageRouteArgs({
    this.key,
    required this.user,
  });

  final _i10.Key? key;

  final _i11.UserModel user;

  @override
  String toString() {
    return 'ChangePasswordPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i8.PasswordOverViewPage]
class PasswordOverViewPageRoute
    extends _i9.PageRouteInfo<PasswordOverViewPageRouteArgs> {
  PasswordOverViewPageRoute({
    _i10.Key? key,
    required _i11.UserModel user,
  }) : super(
          PasswordOverViewPageRoute.name,
          path: '/password-over-view-page',
          args: PasswordOverViewPageRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'PasswordOverViewPageRoute';
}

class PasswordOverViewPageRouteArgs {
  const PasswordOverViewPageRouteArgs({
    this.key,
    required this.user,
  });

  final _i10.Key? key;

  final _i11.UserModel user;

  @override
  String toString() {
    return 'PasswordOverViewPageRouteArgs{key: $key, user: $user}';
  }
}
