import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/theme/theme_service.dart';
import 'package:password_safe/injection.dart';
// import 'package:password_safe/presentation/passwords/password_overview_page.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/theme.dart';
import 'package:provider/provider.dart';

import 'application/auth/authbloc/auth_bloc.dart';
import 'injection.dart' as di; // di == dipendency injection

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl<ThemeService>().init();
  runApp(ChangeNotifierProvider(
      create: ((context) => di.sl<ThemeService>()), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) =>
                  sl<AuthBloc>()..add(AuthCheckRequestedEvent()), //..add(LocalAuthPressedEvent())
            )
          ],
          child: PlatformApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // home: const PasswordOverViewPage(),
            material: (_, __) => MaterialAppRouterData(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode:
                  themeService.isDarkmodeOn ? ThemeMode.dark : ThemeMode.light,
            ),
            cupertino: (_, __) => CupertinoAppRouterData(
              theme: AppTheme.cupertinoDarkTheme,
            ),
          ),
        );
      },
    );
  }
}
