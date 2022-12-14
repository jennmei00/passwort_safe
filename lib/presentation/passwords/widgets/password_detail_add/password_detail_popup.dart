import 'dart:ui';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/injection.dart';
import 'package:password_safe/presentation/core/custom_popup_card.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add_popup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PasswordDetailPopup extends StatelessWidget {
  final Password password;
  final ControllerBloc controllerBloc;
  const PasswordDetailPopup(
      {required this.password, required this.controllerBloc, super.key});

  void _showDeletDialog({
    required BuildContext context,
    //  required ControllerBloc bloc
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
    final double iconSize = 70;

    return CustomPopupCard(
      add: false,
      linkTooltip: password.link,
      buttonPressed: () async {
        try {
          if (password.link.startsWith('https')) {
            await launchUrlString(password.link);
          } else {
            await launchUrlString('https://' + password.link);
          }
        } catch (e) {
          print(e);
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text('Ungültiger Link')), );
        }
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
                top: 20.0, right: 50.0, left: 20.0, bottom: 10.0),
            child: Text(
              password.title,
              style: themeData.textTheme.headline1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(thickness: 2),
          ),
          CustomTextField(
            label: 'NAME',
            enabled: false,
            controller: TextEditingController(text: password.name),
          ),
          CustomTextField(
            label: 'E-MAIL',
            enabled: false,
            controller: TextEditingController(text: password.email),
          ),
          CustomTextField(
            label: 'PASSWORT',
            enabled: false,
            controller: TextEditingController(text: password.password),
            obscurePassword: true,
          ),
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
                    // final controllerBloc = context.read<ControllerBloc>();
                    _showDeletDialog(
                      context: context,
                      // bloc: controllerBloc
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
