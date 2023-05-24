import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/theme.dart';
import 'package:random_password_generator/random_password_generator.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final bool enabled;
  final bool login;
  final String label;
  final Function? validator;
  final Function? randomPassPressed;
  final TextEditingController controller;
  final double textFieldHeight;
  bool obscurePassword;

  CustomTextField({
    required this.label,
    required this.controller,
    this.enabled = true,
    this.login = false,
    this.validator = null,
    this.textFieldHeight = 40,
    this.obscurePassword = false,
    this.randomPassPressed = null,
    super.key,
  });

  final double textFieldWidth = 260;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 15),
              ),
              Container(
                height: label != 'INFO' ? textFieldHeight : null,
                decoration: BoxDecoration(
                    gradient: AppTheme.textFieldGradient,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                  child: Stack(
                    children: [
                      (label == 'PASSWORT' ||
                              label == '* PASSWORT' ||
                              label == 'PASSWORT WIEDERHOLEN' ||
                              label == 'Neues Passwort' ||
                              label == 'Neues Passwort Wiederholen' ||
                              label == 'Altes Passwort')
                          ? Container(
                              padding: EdgeInsets.only(right: 2),
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: (() => setState(
                                    () => obscurePassword = !obscurePassword)),
                                icon: Icon(!obscurePassword
                                    ? CommunityMaterialIcons.eye_off
                                    : CommunityMaterialIcons.eye),
                              ))
                          : SizedBox(),
                      (label == '* PASSWORT')
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {
                                  final passwordGenerator =
                                      RandomPasswordGenerator();
                                  setState(() {
                                    controller.text =
                                        passwordGenerator.randomPassword(
                                            letters: true,
                                            uppercase: true,
                                            numbers: true,
                                            specialChar: true,
                                            passwordLength: 10);
                                  });
                                },
                                icon: Icon(CommunityMaterialIcons.lock_reset),
                              ))
                          : SizedBox(),
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: textFieldHeight),
                        child: Container(
                          alignment: Alignment.center,
                          margin: (label == '* PASSWORT')
                              ? EdgeInsets.symmetric(horizontal: 45)
                              : null,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: label == 'INFO' ? 5 : 0),
                          child: TextFormField(
                            cursorColor:
                                Theme.of(context).colorScheme.secondary,
                            enabled: enabled,
                            validator: validator == null
                                ? null
                                : (value) => validator!(value),
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            controller: controller,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
                            minLines: label == 'INFO' ? 1 : null,
                            maxLines: label == 'INFO' ? 5 : 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
