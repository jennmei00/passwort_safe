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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../passwords/password_overview_page.dart' as _i2;
import '../settings/settings_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    SettingsPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SettingsPage(),
      );
    },
    PasswordOverViewPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.PasswordOverViewPage(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          SettingsPageRoute.name,
          path: '/settings-page',
        ),
        _i3.RouteConfig(
          PasswordOverViewPageRoute.name,
          path: '/',
        ),
      ];
}

/// generated route for
/// [_i1.SettingsPage]
class SettingsPageRoute extends _i3.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: '/settings-page',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i2.PasswordOverViewPage]
class PasswordOverViewPageRoute extends _i3.PageRouteInfo<void> {
  const PasswordOverViewPageRoute()
      : super(
          PasswordOverViewPageRoute.name,
          path: '/',
        );

  static const String name = 'PasswordOverViewPageRoute';
}
