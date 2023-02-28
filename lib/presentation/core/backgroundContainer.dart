import 'package:flutter/material.dart';
import 'package:password_safe/theme.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AppTheme.backgroundImage, fit: BoxFit.fill),
      ),
      width: double.infinity,
      child: child,
    );
  }
}
