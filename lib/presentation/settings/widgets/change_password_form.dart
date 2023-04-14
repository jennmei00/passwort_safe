import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';

class ChangePasswordForm extends StatefulWidget {
  final UserModel user;
  const ChangePasswordForm({super.key, required this.user});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPassword2 = TextEditingController();
  TextEditingController oldPassword = TextEditingController();

  double passowrdHeight = 40;
  double passowrd2Height = 40;

  String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      setState(() {
        passowrdHeight = 60;
      });
      return 'Bitte Passwort eingeben';
    } else if (input.length < 5) {
      setState(() {
        passowrdHeight = 60;
      });
      return 'mind. 5 Zeichen nötig';
    } else if (input == widget.user.password) {
      setState(() {
        passowrdHeight = 60;
      });
      return 'bitte nehme ein anderes Passwort';
    } else {
      setState(() {
        passowrdHeight = 40;
      });
      return null;
    }
  }

  String? validatePassword2(String? input) {
    if (input != newPassword.text) {
      setState(() {
        passowrd2Height = 60;
      });
      return 'Passwörter stimmen nicht überein';
    } else {
      setState(() {
        passowrd2Height = 40;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
            textFieldHeight: passowrdHeight,
            validator: validatePassword,
          ),
          SizedBox(height: 10),
          CustomTextField(
            label: 'Neues Passwort Wiederholen',
            controller: newPassword2,
            enabled: true,
            login: true,
            obscurePassword: true,
            textFieldHeight: passowrd2Height,
            validator: validatePassword2,
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
                    if (_formKey.currentState!.validate()) {
                      try {
                        if (oldPassword.text != widget.user.password) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Altes Passwort stimmt nicht')));
                        } else if (newPassword.text != newPassword2.text) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Passwörter stimmen nicht überein')));
                        } else {
                          BlocProvider.of<AuthBloc>(context).add(
                              ChangePasswordPressedEvent(
                                  user: widget.user,
                                  forgot: false,
                                  newPassword: newPassword.text));

                          // BlocProvider.of<AuthBloc>(context)
                          //     .add(SignOutPressedEvent());
                          context.router.removeUntil(
                              (route) => route == SplashPageRoute());
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
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ändern',
                      style: TextStyle(
                          color: Colors.redAccent.withOpacity(0.5),
                          fontSize: 20),
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
      ),
    );
  }
}
