import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/presentation/core/foldable_button.dart';
import 'package:password_safe/theme.dart';

class CustomContainerCard extends StatelessWidget {
  final Password password;
  final AnimationController foldableButtonAnimationController;
  final List<AnimationController> animationControllers;
  // final IconData ellipseIcon;
  CustomContainerCard({
    required this.password,
    required this.foldableButtonAnimationController,
    required this.animationControllers,
    // required this.ellipseIcon,
    super.key,
  });

  final _key = GlobalKey<ExpandableFabState>();

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      password.title,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: themeData.textTheme.bodyText1,
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: FoldableButton(
              controller: foldableButtonAnimationController,
              animationControllers: animationControllers,
              //   Container(
              // height: tagContainerSize,
              // width: tagContainerSize,
              // decoration: BoxDecoration(
              //     color: themeData.colorScheme.secondary,
              //     shape: BoxShape.circle),
              // child: Icon(
              //   CommunityMaterialIcons.plus,
              //   size: tagIconSize,
              // ),
              // ),
              // Container(
              //   height: tagContainerSize,
              //   width: tagContainerSize,
              //   decoration: BoxDecoration(
              //       color: themeData.colorScheme.secondary,
              //       shape: BoxShape.circle),
              //   child: Icon(
              //     CommunityMaterialIcons.heart,
              //     color: AppTheme.tagHeartColor,
              //     size: tagIconSize,
              //   ),
              // ),
              // Container(
              //   height: tagContainerSize,
              //   width: tagContainerSize,
              //   decoration: BoxDecoration(
              //       color: themeData.colorScheme.secondary,
              //       shape: BoxShape.circle),
              //   child: Icon(
              //     CommunityMaterialIcons.email,
              //     color: AppTheme.tagEmailColor,
              //     size: tagIconSize,
              //   ),
              // ),
              // Container(
              //   height: tagContainerSize,
              //   width: tagContainerSize,
              //   decoration: BoxDecoration(
              //       color: themeData.colorScheme.secondary,
              //       shape: BoxShape.circle),
              //   child: Icon(
              //     CommunityMaterialIcons.web,
              //     color: AppTheme.tagWebColor,
              //     size: tagIconSize,
              //   ),
              // ),
              // ],
            ),
          ),
        ],
      ),
    );
  }
}
