import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';

class PasswordAdd extends StatelessWidget {
  const PasswordAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double imagePlusSize = 80;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Icon(
                  CommunityMaterialIcons.image_plus,
                  size: imagePlusSize,
                ),
              ),
              SizedBox(width: 20),
              Flexible(
                child: Text(
                  'Titel...',
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
          CustomTextField(label: 'VERKNÜPFUNG'),
        ],
      ),
    );
  }
}
