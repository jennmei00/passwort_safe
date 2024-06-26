import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class MenueAccountLine extends StatefulWidget {
  const MenueAccountLine({
    Key? key,
  }) : super(key: key);

  @override
  State<MenueAccountLine> createState() => _MenueAccountLineState();
}

class _MenueAccountLineState extends State<MenueAccountLine> {
  final double containerIconSize = 50;
  final double iconSize = 30;
  final double containerAccountHeight = 50;
  final double containerAccountWidth = 150;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: containerIconSize,
          width: containerIconSize,
          decoration: BoxDecoration(
            color: themeData.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            CommunityMaterialIcons.menu,
            size: iconSize,
          ),
        ),
            Container(
              height: containerIconSize,
              width: containerIconSize,
              decoration: BoxDecoration(
                color: themeData.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () async {
                },
                icon: Icon(CommunityMaterialIcons.cog,
                  size: iconSize,
                ),
              ),
            ),
      ],
    );
  }
}
