import 'dart:ui';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/presentation/passwords/widgets/custom_popup_card.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add_popup.dart';

class PasswordDetailPopup extends StatelessWidget {
  final Password password;
  final ControllerBloc controllerBloc;
  const PasswordDetailPopup(
      {required this.password, required this.controllerBloc, super.key});

  void _showDeletDialog({
    required BuildContext context,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Passwort sicher löschen?"),
            content: Text(
              password.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Abbrechen",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {
                    controllerBloc.add(DeletePasswordEvent(password: password));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Löschen",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double editDeleteIconSize = 30;

    return CustomPopupCard(
      add: false,
      buttonPressed: null,
      icon: password.icon,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
                top: 20.0, right: 50.0, left: 20.0, bottom: 10.0),
            child: Text(
              password.title,
              style: themeData.textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(
              thickness: 2,
              color: themeData.dividerColor,
            ),
          ),
          password.name != ''
              ? CustomTextField(
                  label: 'BENUTZERNAME',
                  enabled: false,
                  controller: TextEditingController(text: password.name),
                )
              : SizedBox(),
          password.email != ''
              ? CustomTextField(
                  label: 'E-MAIL',
                  enabled: false,
                  controller: TextEditingController(text: password.email),
                )
              : SizedBox(),
          CustomTextField(
            label: 'PASSWORT',
            enabled: false,
            controller: TextEditingController(text: password.password),
            obscurePassword: true,
          ),
          password.info != ''
              ? CustomTextField(
                  label: 'INFO',
                  enabled: false,
                  controller: TextEditingController(text: password.info),
                )
              : Container(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      barrierDismissible: true,
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (BuildContext context, _, __) {
                        return Hero(
                          tag: 'add',
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Dialog(
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              child: PasswordAddPopup(
                                password: password,
                              ),
                            ),
                          ),
                        );
                      }));
                },
                icon: Icon(
                  CommunityMaterialIcons.pencil,
                  size: editDeleteIconSize,
                  color: HexColor('#5786FF'),
                ),
              ),
              Flexible(
                child: IconButton(
                  onPressed: () {
                    _showDeletDialog(
                      context: context,
                    );
                  },
                  icon: Icon(
                    CommunityMaterialIcons.delete,
                    size: editDeleteIconSize,
                    color: HexColor('#8C2323'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
