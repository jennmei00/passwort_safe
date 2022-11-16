import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/presentation/passwords/widgets/password_overview_body.dart';
import 'package:password_safe/theme.dart';

class PasswordOverViewPage extends StatelessWidget {
  const PasswordOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return PlatformScaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AppTheme.backgroundImage, fit: BoxFit.fill),
          ),
          child: PasswordOverViewBody()),
    );
  }
}
