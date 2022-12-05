import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_safe/domain/entities/password.dart';

class CustomContainerCard extends StatelessWidget {
  final Password password;
  // final IconData ellipseIcon;
  const CustomContainerCard(
      {required this.password,
      // required this.ellipseIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double tagContainerSize = 48;
    final double containerHeight = 190;
    final double containerWidth = 150;
    final double tagIconSize = 30;
    final double iconSize = 70;

    return Container(
      height: containerHeight + 20,
      width: containerWidth + 20,
      child: Stack(
        children: [
          Center(
            child: Card(
              color: themeData.primaryColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: SizedBox(
                height: containerHeight,
                width: containerWidth,
                child: Column(children: [
                  SizedBox(height: 40),
                  Icon(
                    password.icon,
                    size: iconSize,
                  ),
                  Text(
                    password.title,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: themeData.textTheme.bodyText1,
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: tagContainerSize,
              width: tagContainerSize,
              decoration: BoxDecoration(
                  color: themeData.colorScheme.secondary,
                  shape: BoxShape.circle),
              child: Icon(
                CommunityMaterialIcons.heart,
                color: HexColor('#AE2323'),
                size: tagIconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
