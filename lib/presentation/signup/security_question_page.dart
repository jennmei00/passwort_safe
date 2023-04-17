import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/core/enums.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/theme.dart';

import '../../application/auth/authbloc/auth_bloc.dart';

class SecurityQuestionPage extends StatefulWidget {
  final UserModel user;
  const SecurityQuestionPage({super.key, required this.user});

  @override
  State<SecurityQuestionPage> createState() => _SecurityQuestionPageState();
}

class _SecurityQuestionPageState extends State<SecurityQuestionPage> {
  TextEditingController answerController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double answerHeight = 40;
  int dropdownValue = 0;

  String? validateAnswer(String? input) {
    if (input == null || input.isEmpty) {
      setState(() {
        answerHeight = 60;
      });
      return 'Bitte Antwort eingeben';
    } else {
      setState(() {
        answerHeight = 40;
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
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Text(
                  'Sicherheitsfrage',
                  style: themeData.textTheme.headlineLarge!
                      .copyWith(letterSpacing: 5),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Wähle eine Sicherheitsfrage aus.\nDiese wird benötigt um das Passwort, wenn nötig, zurücksetzen zu können.',
                    style: themeData.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w100),
                    textAlign: TextAlign.justify,
                  ),
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButton<int>(
                              value: dropdownValue,
                              underline: Container(),
                              isExpanded: true,
                              items: SecurityQuestion.values
                                  .map((e) => DropdownMenuItem(
                                      value: e.index,
                                      child: Text(
                                        e.value,
                                        overflow: TextOverflow.visible,
                                      )))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  dropdownValue = val!;
                                });
                              }),
                        ),
                        Form(
                          key: formKey,
                          child: CustomTextField(
                            textFieldHeight: answerHeight,
                            label: 'Antwort',
                            controller: answerController,
                            enabled: true,
                            login: true,
                            validator: validateAnswer,
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Colors.greenAccent.withOpacity(0.3),
                                child: PlatformIconButton(
                                  onPressed: () {
                                    context.router.pop();
                                  },
                                  materialIcon:
                                      Icon(CommunityMaterialIcons.rotate_left),
                                  color: AppTheme.addCardPlusColor,
                                ),
                              ),
                              PlatformElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        RegisterPressedEvent(
                                            user: widget.user.copyWith(
                                                securityQuestionIndex:
                                                    dropdownValue,
                                                securityAnswer:
                                                    answerController.text)));
                                    context.router.popUntil((route) =>
                                        route == SplashPageRoute.name);
                                    context.router
                                        .popAndPush(const SplashPageRoute());
                                  }
                                  ;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Antworten',
                                    style: TextStyle(
                                        color:
                                            Colors.greenAccent.withOpacity(0.5),
                                        fontSize: 20),
                                  ),
                                ),
                                material: (context, platform) =>
                                    MaterialElevatedButtonData(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    )),
                                  ),
                                ),
                              ),
                            ],
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
    );
  }
}
