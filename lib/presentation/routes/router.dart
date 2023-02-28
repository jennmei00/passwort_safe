import 'package:auto_route/auto_route.dart';
import 'package:password_safe/presentation/passwords/password_overview_page.dart';
import 'package:password_safe/presentation/settings/settings_page.dart';
import 'package:password_safe/presentation/signup/login_page.dart';
import 'package:password_safe/presentation/signup/signup_page.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SignUpPage, initial: true),
  AutoRoute(page: LoginPage, initial: false),
  AutoRoute(page: SettingsPage, initial: false),
  AutoRoute(page: PasswordOverViewPage, initial: false),
])
class $AppRouter {}
