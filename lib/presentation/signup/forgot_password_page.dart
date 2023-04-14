import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/core/enums.dart';
import 'package:password_safe/domain/repositories/auth_repository.dart';
import 'package:password_safe/infrastructure/datasources/db_local_datasource.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/infrastructure/repositories/auth_repository_impl.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/presentation/signup/widgets/reset_card.dart';
import 'package:password_safe/presentation/splash/splash_page.dart';
import 'package:password_safe/theme.dart';

import '../../application/auth/authbloc/auth_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  final UserModel user;
  const ForgotPasswordPage({super.key, required this.user});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool passwordReset = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return PlatformScaffold(
      body: BackgroundContainer(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              Text(
                passwordReset ? 'Passwort Zurücksetzen' : 'Sicherheitsfrage',
                style: themeData.textTheme.headlineLarge!
                    .copyWith(letterSpacing: 5),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                passwordReset
                    ? 'Gebe dein neues Passwort ein.'
                    : SecurityQuestion
                        .values[widget.user.securityQuestionIndex].value,
                style: themeData.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w100),
                textAlign: TextAlign.center,
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
                      child: passwordReset
                          ? ResetCard(
                              user: widget.user,
                            )
                          : SecurityQuestionCard(context, widget.user)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SecurityQuestionCard(BuildContext context, UserModel user) {
    TextEditingController answerController = TextEditingController();

    return Column(children: [
      CustomTextField(
        label: 'Antwort',
        controller: answerController,
        enabled: true,
        login: true,
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.greenAccent.withOpacity(0.3),
              child: PlatformIconButton(
                onPressed: () {
                  context.router.pop();
                },
                materialIcon: Icon(CommunityMaterialIcons.rotate_left),
                color: AppTheme.addCardPlusColor,
              ),
            ),
            PlatformElevatedButton(
              onPressed: () async {
                if (user.securityAnswer != answerController.text) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Falsche Antwort')));
                } else {
                  setState(() {
                    passwordReset = true;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Antworten',
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
    ]);
  }
}
