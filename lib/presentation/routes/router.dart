import 'package:auto_route/auto_route.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';

// * * Run the generator with
// * * flutter packages pub run build_runner watch/build
// * * [watch] flag to watch the files' system for edits and rebuild as necessary
// * * [build] flag if you want the generator to run one time and exit

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: SecurityQuestionRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),
        AutoRoute(page: ChangeSecurityQuestionRoute.page),
        AutoRoute(page: PasswordOverViewRoute.page),
      ];
}
