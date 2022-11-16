import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_detail.dart';

class CustomContainerCard extends StatelessWidget {
  // final IconData ellipseIcon;
  const CustomContainerCard(
      {
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
            child: Container(
              height: containerHeight,
              width: containerWidth,
              decoration: BoxDecoration(
                color: themeData.primaryColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(children: [
                SizedBox(height: 40),
                Icon(
                  CommunityMaterialIcons.cart_variant,
                  size: iconSize,
                ),
                Text(
                  'Amazon Prime',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.bodyText1,
                ),
              ]),
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
