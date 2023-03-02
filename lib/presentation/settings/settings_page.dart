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
    final themeData = Theme.of(context);

    return PlatformScaffold(
      body: BackgroundContainer(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  PlatformIconButton(
                    materialIcon: Icon(CommunityMaterialIcons.arrow_left_bold),
                    cupertinoIcon: Icon(CupertinoIcons.back),
                    onPressed: () => AutoRouter.of(context).pop(),
                  ),
                  Text('     Einstellungen')
                ],
              ),
              SizedBox(height: 20),
              Card(
                color: themeData.primaryColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Anmeldung',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(thickness: 3),
                        ListTile(
                          title: GestureDetector(
                              onTap: () {}, child: Text('Passwort ändern')),
                        ),
                        SwitchListTile(
                          value: false,
                          onChanged: (val) {},
                          title: Text('Biometr. Authentifizierung'),
                        ),
                      ]),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: themeData.primaryColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Daten',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(thickness: 3),
                        ListTile(
                          title: GestureDetector(
                              onTap: () {}, child: Text('CSV Import')),
                        ),
                        ListTile(
                          title: GestureDetector(
                              onTap: () {}, child: Text('CSV Export')),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
