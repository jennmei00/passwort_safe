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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../passwords/password_overview_page.dart' as _i4;
import '../settings/settings_page.dart' as _i3;
import '../signup/login_page.dart' as _i2;
import '../signup/signup_page.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SignUpPageRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SignUpPage(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SettingsPage(),
      );
    },
    PasswordOverViewPageRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.PasswordOverViewPage(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          SignUpPageRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i5.RouteConfig(
          SettingsPageRoute.name,
          path: '/settings-page',
        ),
        _i5.RouteConfig(
          PasswordOverViewPageRoute.name,
          path: '/password-over-view-page',
        ),
      ];
}

/// generated route for
/// [_i1.SignUpPage]
class SignUpPageRoute extends _i5.PageRouteInfo<void> {
  const SignUpPageRoute()
      : super(
          SignUpPageRoute.name,
          path: '/',
        );

  static const String name = 'SignUpPageRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageRoute extends _i5.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i3.SettingsPage]
class SettingsPageRoute extends _i5.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: '/settings-page',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i4.PasswordOverViewPage]
class PasswordOverViewPageRoute extends _i5.PageRouteInfo<void> {
  const PasswordOverViewPageRoute()
      : super(
          PasswordOverViewPageRoute.name,
          path: '/password-over-view-page',
        );

  static const String name = 'PasswordOverViewPageRoute';
}
