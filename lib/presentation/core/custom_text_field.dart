import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/theme.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final bool enabled;
  final bool login;
  final String label;
  final Function? validator;
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
    super.key,
  });

  final double textFieldWidth = 260;
  final double linkIconSize = 30;

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
                height: label != 'ZUSATZ' ? textFieldHeight : null,
                decoration: BoxDecoration(
                    gradient: AppTheme.textFieldGradient,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                  child: Stack(
                    children: [
                      (label == 'VERKNÜPFUNG')
                          ? Container(
                              padding: EdgeInsets.only(left: 2),
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                  CommunityMaterialIcons.link_variant_plus))
                          : SizedBox(),
                      ((label == 'PASSWORT' ||
                                  label == 'PASSWORT WIEDERHOLEN' || label == 'Neues Passwort' || label == 'Neues Passwort Wiederholen' || label == 'Altes Passwort') &&
                              (!enabled || login))
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
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: textFieldHeight),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: label == 'ZUSATZ' ? 5 : 0),
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
                            minLines: label == 'ZUSATZ' ? 1 : null,
                            maxLines: label == 'ZUSATZ' ? 5 : 1,
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
