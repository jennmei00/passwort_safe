import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: BackgroundContainer(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  PlatformIconButton(
                    materialIcon: Icon(CommunityMaterialIcons.arrow_left),
                    cupertinoIcon: Icon(CupertinoIcons.back),
                    onPressed: () => AutoRouter.of(context).pop(),
                  ),
                  Text('Einstellungen')
                ],
              ),
              SizedBox(height: 20),
              Expanded(child: Placeholder())
            ],
          ),
        ),
      ),
    );
  }
}
