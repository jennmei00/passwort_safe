import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';

class PasswordDetail extends StatelessWidget {
  const PasswordDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double editDeleteIconSize = 30;
    final double iconSize = 80;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Icon(
                  CommunityMaterialIcons.cart_variant,
                  size: iconSize,
                ),
              ),
              SizedBox(width: 20),
              Flexible(
                child: Text(
                  'Amazon Prime',
                  style: themeData.textTheme.headline1,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(thickness: 2),
          ),
          CustomTextField(label: 'NAME'),
          CustomTextField(label: 'E-MAIL'),
          CustomTextField(label: 'PASSWORT'),
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
                  onPressed: () {},
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
