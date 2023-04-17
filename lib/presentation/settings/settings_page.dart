import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/infrastructure/datasources/db_local_datasource.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/presentation/settings/widgets/change_name_form.dart';
import 'package:password_safe/presentation/settings/widgets/dialog_widget.dart';
import 'package:password_safe/theme.dart';

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
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Row(
                  children: [
                    PlatformIconButton(
                      materialIcon:
                          Icon(CommunityMaterialIcons.arrow_left_bold),
                      cupertinoIcon: Icon(CupertinoIcons.back),
                      onPressed: () => AutoRouter.of(context).pop(),
                    ),
                    Text('     Einstellungen')
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '* Bei Änderung wird die App automatisch neu geladen!',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Divider(thickness: 3),
                                ListTile(
                                  title: ChangeNameForm(user: widget.user),
                                ),
                                ListTile(
                                  title: GestureDetector(
                                      onTap: () {
                                        context.router.push(
                                            ChangePasswordPageRoute(
                                                user: widget.user));
                                      },
                                      child: Text('Passwort ändern')),
                                ),
                                SwitchListTile(
                                  value: widget.user.bioAuth,
                                  onChanged: (val) async {
                                    if (val) {
                                      try {
                                        await LocalAuthentication()
                                            .authenticate(
                                                localizedReason:
                                                    'Authentifizieren, um die Anmeldeart zu genehmigen.')
                                            .then((value) {
                                          if (value) {
                                            setBioAuth(context, value);
                                          }
                                        });
                                      } catch (e) {
                                        print(e);
                                        if (e is PlatformException) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            'Dein Gerät verfügt nicht über diese Funktion.',
                                            style:
                                                AppTheme.darkSnackBarTextStyle,
                                          )));
                                        }
                                      }
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(thickness: 3),
                                // ListTile(
                                //   title: GestureDetector(
                                //       onTap: () {}, child: Text('CSV Import')),
                                // ),
                                // ListTile(
                                //   title: GestureDetector(
                                //       onTap: () {}, child: Text('CSV Export')),
                                // ),
                                ListTile(
                                  title: GestureDetector(
                                    onTap: () {
                                      showPlatformDialog(
                                        context: context,
                                        builder: (context) => DialogWidget(
                                            icon: Icon(CommunityMaterialIcons
                                                .database_remove),
                                            title: 'Daten löschen',
                                            content:
                                                'Bist du sicher, das du deine Daten löschen willst?',
                                            deletePressed: () async {
                                              try {
                                                await DBLocalDatasourceImpl()
                                                    .deleteDatabase();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    'Deine Daten wurden gelöscht',
                                                    style: AppTheme
                                                        .darkSnackBarTextStyle,
                                                  ),
                                                ));
                                                context.router.pop();
                                                context.router.popAndPush(
                                                    PasswordOverViewPageRoute(
                                                        user: widget.user));
                                              } catch (e) {
                                                print(e);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    content: Text(
                                                      'Etwas ist schiefgelaufen :(',
                                                    ),
                                                  ),
                                                );
                                                context.router.pop();
                                              }
                                            }),
                                      );
                                    },
                                    child: Text(
                                      'Daten löschen',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: GestureDetector(
                                    onTap: () {
                                      showPlatformDialog(
                                        context: context,
                                        builder: (context) => DialogWidget(
                                            icon: Icon(CommunityMaterialIcons
                                                .account_remove),
                                            title: 'Konto löschen',
                                            content:
                                                'Bist du sicher, das du dein komplettes Konto löschen willst?',
                                            deletePressed: () async {
                                              try {
                                                await DBLocalDatasourceImpl()
                                                    .deleteDatabase();

                                                BlocProvider.of<AuthBloc>(
                                                        context)
                                                    .add(
                                                        DeleteAccountPressedEvent());
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    'Dein Konto wurde gelöscht',
                                                    style: AppTheme
                                                        .darkSnackBarTextStyle,
                                                  ),
                                                ));
                                                context.router.pop();
                                                context.router.popAndPush(
                                                    SplashPageRoute());
                                              } catch (e) {
                                                print(e);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    content: Text(
                                                        'Etwas ist schiefgelaufen :('),
                                                  ),
                                                );
                                                context.router.pop();
                                              }
                                            }),
                                      );
                                    },
                                    child: Text(
                                      'Konto löschen',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
