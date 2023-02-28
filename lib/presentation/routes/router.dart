import 'package:auto_route/auto_route.dart';
import 'package:password_safe/presentation/passwords/password_overview_page.dart';
import 'package:password_safe/presentation/settings/settings_page.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SettingsPage, initial: false),
  AutoRoute(page: PasswordOverViewPage, initial: true),
])
class $AppRouter {}
