import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/presentation/core/custom_popup_card.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';

class PasswordDetailPopup extends StatelessWidget {
  final Password password;
  const PasswordDetailPopup({required this.password, super.key});

  void _showDeletDialog(
      {required BuildContext context, required ControllerBloc bloc}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Selected Todo to delete:"),
            content: Text(
              password.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "CANCLE",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {
                    bloc.add(DeletePasswordEvent(password: password));
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "DELETE",
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
      buttonPressed: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 50.0, left: 5.0),
            child: Row(
              children: [
                Icon(
                  CommunityMaterialIcons.cart_variant,
                  size: iconSize,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    password.title,
                    style: themeData.textTheme.headline1,
                  ),
                ),
              ],
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
                onPressed: () {},
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
                    // _showDeletDialog(context: context, bloc: controllerBloc);
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
