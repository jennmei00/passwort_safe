import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();

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
              Text('Hallo Jenny.', style: themeData.textTheme.headlineLarge,),
              SizedBox(height: 20),
              Text(
                'Bitte melde dich an.',
                style: themeData.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w100),
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
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.5),
                              child: PlatformIconButton(
                                onPressed: () {},
                                materialIcon:
                                    Icon(CommunityMaterialIcons.rotate_left),
                                color: Color.fromARGB(255, 100, 5, 5),
                              ),
                            ),
                            PlatformElevatedButton(
                              onPressed: () {},
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
    );
  }
}
