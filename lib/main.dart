import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/theme/theme_service.dart';
import 'package:password_safe/presentation/passwords/password_overview_page.dart';
import 'package:password_safe/theme.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di; // di == dipendency injection

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl<ThemeService>().init();
  runApp(ChangeNotifierProvider(
      create: ((context) => di.sl<ThemeService>()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return PlatformApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: const PasswordOverViewPage(),
          material: (_, __) => MaterialAppData(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode:
                themeService.isDarkmodeOn ? ThemeMode.dark : ThemeMode.light,
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: AppTheme.cupertinoDarkTheme,
          ),
        );
      },
    );
  }
}
