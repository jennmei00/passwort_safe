import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:password_safe/theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  const CustomTextField({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    // final themeData = Theme.of(context);
    final double textFieldWidth = 260;
    final double textFieldHeight = 40;
    final double linkIconSize = 30;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(label),
          Container(
            height: textFieldHeight,
            width: textFieldWidth,
            decoration: BoxDecoration(
                gradient: AppTheme.textFieldGradient,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // child: Row(
            //   children: [
            // if (label == 'VERKNÜPFUNG')
            //   Padding(
            //     padding: const EdgeInsets.only(left: 5.0),
            //     child: Icon(CommunityMaterialIcons.link_variant_plus, size: linkIconSize,),
            //   ),
            // Expanded(
            child: TextFormField(
              // style: themeData,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                suffixIcon: (label == 'PASSWORT')
                    ? Icon(
                        CommunityMaterialIcons.eye,
                        size: linkIconSize,
                      )
                    : null,
                prefixIcon: (label == 'VERKNÜPFUNG')
                    ? Icon(
                        CommunityMaterialIcons.link_variant_plus,
                        size: linkIconSize,
                      )
                    : null,
                border: InputBorder.none,
              ),
            ),
            //   ),
            // ],
            // ),
          ),
        ],
      ),
    );
  }
}
