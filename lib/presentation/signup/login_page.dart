import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/theme.dart';

import '../../application/auth/authbloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  final UserModel user;
  const LoginPage({super.key, required this.user});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  bool bioAuth = false;

  Future<void> checkBioAuth(BuildContext context) async {
    if (bioAuth) {
      bool success = await LocalAuthentication().authenticate(
              localizedReason:
                  'Authentifizieren, um die Anmeldeart zu genehmigen.')
          ;
      if (success) {
        BlocProvider.of<AuthBloc>(context).add(LoginPressedEvent(
            password: widget.user.password, user: widget.user));
        context.router.replace(const SplashPageRoute());
      }
    }
  }

  @override
  void initState() {
    bioAuth = widget.user.bioAuth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    checkBioAuth(context);

    return PlatformScaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 25),
                    Text(
                      'Hallo ${widget.user.name}.',
                      style: themeData.textTheme.headlineLarge!
                          .copyWith(letterSpacing: 5),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Bitte melde dich an.',
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
                              label: 'PASSWORT',
                              controller: passwordController,
                              enabled: true,
                              login: true,
                              obscurePassword: true,
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.redAccent.withOpacity(0.5),
                                    child: PlatformIconButton(
                                      onPressed: () {
                                        context.router.push(
                                            ForgotPasswordPageRoute(
                                                user: widget.user));
                                      },
                                      materialIcon: Icon(
                                          CommunityMaterialIcons.rotate_left),
                                      color: Color.fromARGB(255, 100, 5, 5),
                                    ),
                                  ),
                                  PlatformElevatedButton(
                                    onPressed: () async {
                                      print('LOGIN');
                                      print(widget.user.password);
                                      if (widget.user.password !=
                                          passwordController.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          'Falsches Passwort',
                                          style: AppTheme.darkSnackBarTextStyle,
                                        )));
                                      } else {
                                        BlocProvider.of<AuthBloc>(context).add(
                                            LoginPressedEvent(
                                                password:
                                                    passwordController.text,
                                                user: widget.user));
                                        context.router
                                            .replace(const SplashPageRoute());
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Login',
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
              widget.user.bioAuth
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: FloatingActionButton(
                            onPressed: () {
                              checkBioAuth(context);
                            },
                            child: Icon(
                              CommunityMaterialIcons.fingerprint,
                              size: 50,
                            ),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
