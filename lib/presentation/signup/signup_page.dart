import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double textFieldHeight = 40;
  double nameHeight = 40;
  double passowrdHeight = 40;
  double passowrd2Height = 40;

  String? validateName(String? input) {
    if (input == null || input.isEmpty) {
      setState(() {
        nameHeight = 60;
      });
      return 'Bitte Name eingeben';
    } else {
      setState(() {
        nameHeight = 40;
      });
      return null;
    }
  }

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
    } else {
      setState(() {
        passowrdHeight = 40;
      });
      return null;
    }
  }

  String? validatePassword2(String? input) {
    if (input != passwordController.text) {
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
    final themeData = Theme.of(context);

    return PlatformScaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 25),
                        Text(
                          'Willkommen.',
                          style: themeData.textTheme.headlineLarge!
                              .copyWith(letterSpacing: 5),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Bitte registriere dich.',
                          style: themeData.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w100),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: themeData.primaryColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                CustomTextField(
                                  label: 'NAME',
                                  controller: nameController,
                                  textFieldHeight: nameHeight,
                                  validator: validateName,
                                ),
                                CustomTextField(
                                  label: 'PASSWORT',
                                  controller: passwordController,
                                  enabled: true,
                                  login: true,
                                  obscurePassword: true,
                                  textFieldHeight: passowrdHeight,
                                  validator: validatePassword,
                                ),
                                CustomTextField(
                                  label: 'PASSWORT WIEDERHOLEN',
                                  controller: password2Controller,
                                  enabled: true,
                                  login: true,
                                  obscurePassword: true,
                                  textFieldHeight: passowrd2Height,
                                  validator: validatePassword2,
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: PlatformElevatedButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          context.router
                                              .push(SecurityQuestionPageRoute(
                                                  user: UserModel(
                                            name: nameController.text,
                                            password: passwordController.text,
                                            securityQuestionIndex: 0,
                                            securityAnswer: '',
                                            bioAuth: false,
                                          )));
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Registrieren',
                                          style: TextStyle(
                                              color: AppTheme.addCardPlusColor,
                                              fontSize: 20),
                                        ),
                                      ),
                                      material: (context, platform) =>
                                          MaterialElevatedButtonData(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
