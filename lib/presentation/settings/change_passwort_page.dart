import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/theme.dart';

class ChangePasswordPage extends StatefulWidget {
  final UserModel user;

  const ChangePasswordPage({super.key, required this.user});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return PlatformScaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    PlatformIconButton(
                      materialIcon:
                          Icon(CommunityMaterialIcons.arrow_left_bold),
                      cupertinoIcon: Icon(CupertinoIcons.back),
                      onPressed: () => AutoRouter.of(context).pop(),
                    ),
                    Text('     Passwort ändern')
                  ],
                ),
                // SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                            child: ChangePasswordForm(context, widget.user),
                          ),
                        ),
                      ],
                    ),
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

Widget ChangePasswordForm(BuildContext context, UserModel user) {
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPassword2 = TextEditingController();
  TextEditingController oldPassword = TextEditingController();

  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CustomTextField(
        label: 'Altes Passwort',
        controller: oldPassword,
        enabled: true,
        login: true,
        obscurePassword: true,
      ),
      CustomTextField(
        label: 'Neues Passwort',
        controller: newPassword,
        enabled: true,
        login: true,
        obscurePassword: true,
      ),
      SizedBox(height: 10),
      CustomTextField(
        label: 'Neues Passwort Wiederholen',
        controller: newPassword2,
        enabled: true,
        login: true,
        obscurePassword: true,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // CircleAvatar(
            //   backgroundColor: Colors.greenAccent.withOpacity(0.3),
            //   child: PlatformIconButton(
            //     onPressed: () {
            //       // context.router.pop();
            //     },
            //     materialIcon: Icon(CommunityMaterialIcons.rotate_left),
            //     color: AppTheme.addCardPlusColor,
            //   ),
            // ),
            PlatformElevatedButton(
              onPressed: () async {
                try {
                  if (oldPassword.text != user.password) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Altes Passwort stimmt nicht')));
                  } else if (newPassword.text != newPassword2.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Passwörter stimmen nicht überein')));
                  } else {
                    BlocProvider.of<AuthBloc>(context).add(
                        ChangePasswordPressedEvent(
                            user: user,
                            forgot: false,
                            newPassword: newPassword.text));

                    // BlocProvider.of<AuthBloc>(context)
                    //     .add(SignOutPressedEvent());
                    context.router
                        .removeUntil((route) => route == SplashPageRoute());
                    context.router.push(const SplashPageRoute());

                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text('Passwort wurde erfolgreich geändert')));
                  }
                } catch (e) {
                  print(e);
                }
                // if (newPassword.text != newPassword2.text) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //       content: Text('Passwörter stimmen nicht überein')));
                // } else {
                //   BlocProvider.of<AuthBloc>(context)
                //       .add(ChangePasswordPressedEvent(
                //     user: widget.user,
                //     forgot: true,
                //     newPassword: newPassword.text,
                //   ));
                //   context.router.replace(LoginPageRoute(
                //       user: widget.user.copyWith(password: newPassword.text)));
                // }
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('Passwort wurde zurückgesetzt')));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ändern',
                  style: TextStyle(
                      color: Colors.redAccent.withOpacity(0.5), fontSize: 20),
                ),
              ),
              material: (context, platform) => MaterialElevatedButtonData(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}
