import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class AccountAnimatedOpacity extends StatelessWidget {
  const AccountAnimatedOpacity({
    Key? key,
    required bool accountSettingsVisible,
    required this.containerAccountWidth,
    required this.containerAccountHeight,
    required this.themeData,
    required this.iconSize,
  })  : _accountSettingsVisible = accountSettingsVisible,
        super(key: key);

  final bool _accountSettingsVisible;
  final double containerAccountWidth;
  final double containerAccountHeight;
  final ThemeData themeData;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _accountSettingsVisible ? 1 : 0,
      duration: Duration(seconds: 1),
      child: Container(
        width: containerAccountWidth,
        height: containerAccountHeight,
        decoration: BoxDecoration(
          color: themeData.colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CommunityMaterialIcons.logout,
                  size: iconSize,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CommunityMaterialIcons.cog,
                  size: iconSize,
                ),
              ),
            ],
          )),
          SizedBox(width: 50),
        ]),
        // ).animate().fadeIn(begin: 0),
      ),
    );
  }
}
