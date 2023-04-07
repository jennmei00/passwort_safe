import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/presentation/settings/change_passwort_page.dart';
import 'package:password_safe/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final UserModel user;

  SettingsPage({super.key, required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> setBioAuth(BuildContext context, bool ba) async {
    BlocProvider.of<AuthBloc>(context)
        .add(ChangeBioAuthPressedEvent(bioAuth: ba, user: widget.user));

    context.router.removeUntil((route) => route == SplashPageRoute());
    context.router.push(const SplashPageRoute());
  }

  @override
  void initState() {
    super.initState();
  }

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
                              onTap: () {
                                context.router.push(
                                    ChangePasswordPageRoute(user: widget.user));
                              },
                              child: Text('Passwort ändern')),
                        ),
                        SwitchListTile(
                          value: widget.user.bioAuth,
                          onChanged: (val) async {
                            if (val) {
                              await LocalAuthentication()
                                  .authenticate(
                                      localizedReason:
                                          'Authentifizieren, um die Anmeldeart zu genehmigen.')
                                  .then((value) {
                                if (value) {
                                  setBioAuth(context, value);
                                }
                              });
                            } else {
                              setBioAuth(context, val);
                            }
                          },
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
