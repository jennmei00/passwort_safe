import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:file_picker/file_picker.dart';
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
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/presentation/settings/widgets/change_name_form.dart';
import 'package:password_safe/presentation/settings/widgets/dialog_widget.dart';
import 'package:password_safe/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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

  void importDB() async {
    //delete cache to delete old database data
    var tempDir = await getTemporaryDirectory();
    bool existTempDir = await tempDir.exists();
    if (existTempDir) {
      await tempDir.delete(recursive: true);
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      if (file.path.endsWith('PasswordSafeDownload.db')) {
        final dbPath = await getDatabasesPath() + '/PasswordSafe.db';
        var dbFileBytes = file.readAsBytesSync();
        var bytes = ByteData.view(dbFileBytes.buffer);
        final buffer = bytes.buffer;
        await File(dbPath).writeAsBytes(buffer.asUint8List(
            dbFileBytes.offsetInBytes, dbFileBytes.lengthInBytes));

        context.router.pop();
        context.router.popAndPush(PasswordOverViewPageRoute(user: widget.user));
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Ungültige Datei',
          style: AppTheme.darkSnackBarTextStyle,
        )));
      }
    } else {
      //canceld pick
      print('canceld pick');
    }
  }

  void exportDB() async {
    try {
      String dbName = "PasswordSafeDownload.db";
      String? downloadPath = await getDownloadPath();
      final dbPath = await getDatabasesPath();
      var dbFile = File('$dbPath/PasswordSafe.db');
      var filePath = downloadPath! + '/$dbName';
      var dbFileBytes = dbFile.readAsBytesSync();
      var bytes = ByteData.view(dbFileBytes.buffer);
      final buffer = bytes.buffer;

      File(filePath).writeAsBytes(buffer.asUint8List(
          dbFileBytes.offsetInBytes, dbFileBytes.lengthInBytes));

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Datenbank wurde in Downloadordner kopiert.',
            style: AppTheme.darkSnackBarTextStyle,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Konnte nicht gespeichert werden!',
            style: AppTheme.darkSnackBarTextStyle,
          ),
        ),
      );
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (ex) {
      print("Cannot get download folder path");
    }
    return directory?.path;
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
                                Divider(
                                  thickness: 3,
                                  color: themeData.dividerColor,
                                ),
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
                                ListTile(
                                  title: GestureDetector(
                                      onTap: () {
                                        context.router.push(
                                            ChangeSecurityQuestionPageRoute(
                                                user: widget.user));
                                      },
                                      child: Text('Sicherheitsfrage ändern')),
                                ),
                                SwitchListTile(
                                  value: widget.user.bioAuth,
                                  inactiveThumbColor:
                                      Theme.of(context).primaryColor,
                                  inactiveTrackColor: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.7),
                                  trackOutlineColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  activeColor: Colors.black,
                                  activeTrackColor:
                                      Theme.of(context).colorScheme.secondary,
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
                                              .hideCurrentSnackBar();
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
                                Divider(
                                  thickness: 3,
                                  color: themeData.dividerColor,
                                ),
                                ListTile(
                                  title: GestureDetector(
                                      onTap: () => importDB(),
                                      child: Text('Import')),
                                ),
                                ListTile(
                                  title: GestureDetector(
                                      onTap: () => exportDB(),
                                      child: Text('Export')),
                                ),
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
                                                    .hideCurrentSnackBar();
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
                                                    .hideCurrentSnackBar();
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
                                                    .hideCurrentSnackBar();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    'Dein Konto wurde gelöscht',
                                                    style: AppTheme
                                                        .darkSnackBarTextStyle,
                                                  ),
                                                ));
                                                context.router.popUntilRoot();
                                              } catch (e) {
                                                print(e);
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
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
