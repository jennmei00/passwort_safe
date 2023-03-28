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
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../infrastructure/models/user_model.dart' as _i9;
import '../passwords/password_overview_page.dart' as _i6;
import '../settings/settings_page.dart' as _i5;
import '../signup/forgot_password_page.dart' as _i3;
import '../signup/login_page.dart' as _i4;
import '../signup/signup_page.dart' as _i2;
import '../splash/splash_page.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignUpPage(),
      );
    },
    ForgotPasswordPageRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordPageRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.ForgotPasswordPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.LoginPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.SettingsPage(),
      );
    },
    PasswordOverViewPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.PasswordOverViewPage(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          SplashPageRoute.name,
          path: '/',
        ),
        _i7.RouteConfig(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        ),
        _i7.RouteConfig(
          ForgotPasswordPageRoute.name,
          path: '/forgot-password-page',
        ),
        _i7.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i7.RouteConfig(
          SettingsPageRoute.name,
          path: '/settings-page',
        ),
        _i7.RouteConfig(
          PasswordOverViewPageRoute.name,
          path: '/password-over-view-page',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i7.PageRouteInfo<void> {
  const SplashPageRoute()
      : super(
          SplashPageRoute.name,
          path: '/',
        );

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.SignUpPage]
class SignUpPageRoute extends _i7.PageRouteInfo<void> {
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
    extends _i7.PageRouteInfo<ForgotPasswordPageRouteArgs> {
  ForgotPasswordPageRoute({
    _i8.Key? key,
    required _i9.UserModel user,
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

  final _i8.Key? key;

  final _i9.UserModel user;

  @override
  String toString() {
    return 'ForgotPasswordPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i4.LoginPage]
class LoginPageRoute extends _i7.PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({
    _i8.Key? key,
    required _i9.UserModel user,
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

  final _i8.Key? key;

  final _i9.UserModel user;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i5.SettingsPage]
class SettingsPageRoute extends _i7.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: '/settings-page',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i6.PasswordOverViewPage]
class PasswordOverViewPageRoute extends _i7.PageRouteInfo<void> {
  const PasswordOverViewPageRoute()
      : super(
          PasswordOverViewPageRoute.name,
          path: '/password-over-view-page',
        );

  static const String name = 'PasswordOverViewPageRoute';
}
