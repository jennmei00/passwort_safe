import 'package:auto_route/auto_route.dart';
import 'package:password_safe/presentation/passwords/password_overview_page.dart';
import 'package:password_safe/presentation/settings/settings_page.dart';
import 'package:password_safe/presentation/signup/forgot_password_page.dart';
import 'package:password_safe/presentation/signup/login_page.dart';
import 'package:password_safe/presentation/signup/security_question_page.dart';
import 'package:password_safe/presentation/signup/signup_page.dart';
import 'package:password_safe/presentation/splash/splash_page.dart';

// * * Run the generator with
// * * flutter packages pub run build_runner watch/build
// * * [watch] flag to watch the files' system for edits and rebuild as necessary
// * * [build] flag if you want the generator to run one time and exit

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: SignUpPage, initial: false),
  AutoRoute(page: ForgotPasswordPage, initial: false),
  AutoRoute(page: SecurityQuestionPage, initial: false),
  AutoRoute(page: LoginPage, initial: false),
  AutoRoute(page: SettingsPage, initial: false),
  AutoRoute(page: PasswordOverViewPage, initial: false),
])
class $AppRouter {}
