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
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../infrastructure/models/user_model.dart' as _i10;
import '../passwords/password_overview_page.dart' as _i7;
import '../settings/settings_page.dart' as _i6;
import '../signup/forgot_password_page.dart' as _i3;
import '../signup/login_page.dart' as _i5;
import '../signup/security_question_page.dart' as _i4;
import '../signup/signup_page.dart' as _i2;
import '../splash/splash_page.dart' as _i1;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignUpPage(),
      );
    },
    ForgotPasswordPageRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordPageRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.ForgotPasswordPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    SecurityQuestionPageRoute.name: (routeData) {
      final args = routeData.argsAs<SecurityQuestionPageRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.SecurityQuestionPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.LoginPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SettingsPage(),
      );
    },
    PasswordOverViewPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.PasswordOverViewPage(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          SplashPageRoute.name,
          path: '/',
        ),
        _i8.RouteConfig(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        ),
        _i8.RouteConfig(
          ForgotPasswordPageRoute.name,
          path: '/forgot-password-page',
        ),
        _i8.RouteConfig(
          SecurityQuestionPageRoute.name,
          path: '/security-question-page',
        ),
        _i8.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i8.RouteConfig(
          SettingsPageRoute.name,
          path: '/settings-page',
        ),
        _i8.RouteConfig(
          PasswordOverViewPageRoute.name,
          path: '/password-over-view-page',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i8.PageRouteInfo<void> {
  const SplashPageRoute()
      : super(
          SplashPageRoute.name,
          path: '/',
        );

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.SignUpPage]
class SignUpPageRoute extends _i8.PageRouteInfo<void> {
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
    extends _i8.PageRouteInfo<ForgotPasswordPageRouteArgs> {
  ForgotPasswordPageRoute({
    _i9.Key? key,
    required _i10.UserModel user,
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

  final _i9.Key? key;

  final _i10.UserModel user;

  @override
  String toString() {
    return 'ForgotPasswordPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i4.SecurityQuestionPage]
class SecurityQuestionPageRoute
    extends _i8.PageRouteInfo<SecurityQuestionPageRouteArgs> {
  SecurityQuestionPageRoute({
    _i9.Key? key,
    required _i10.UserModel user,
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

  final _i9.Key? key;

  final _i10.UserModel user;

  @override
  String toString() {
    return 'SecurityQuestionPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i5.LoginPage]
class LoginPageRoute extends _i8.PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({
    _i9.Key? key,
    required _i10.UserModel user,
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

  final _i9.Key? key;

  final _i10.UserModel user;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsPageRoute extends _i8.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: '/settings-page',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i7.PasswordOverViewPage]
class PasswordOverViewPageRoute extends _i8.PageRouteInfo<void> {
  const PasswordOverViewPageRoute()
      : super(
          PasswordOverViewPageRoute.name,
          path: '/password-over-view-page',
        );

  static const String name = 'PasswordOverViewPageRoute';
}
