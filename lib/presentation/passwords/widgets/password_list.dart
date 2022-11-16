import 'package:blur/blur.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/presentation/core/custom_container_card.dart';
import 'package:password_safe/presentation/core/custom_popup_card.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add.dart';
import 'package:password_safe/theme.dart';

class PasswordList extends StatelessWidget {
  const PasswordList({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double tagContainerSize = 48;
    final double containerHeight = 190;
    final double containerWidth = 150;
    final double tagIconSize = 30;
    final double iconSize = 70;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (containerWidth / containerHeight),
      children: [
        Hero(
          tag: 'add',
          child: Center(
            child: Container(
              height: containerHeight,
              width: containerWidth,
              decoration: BoxDecoration(
                color: AppTheme.addCardColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      barrierDismissible: true,
                      transitionDuration: Duration(seconds: 2),
                      pageBuilder: (BuildContext context, _, __) {
                        return Hero(
                          tag: 'add',
                          child: Dialog(
                            backgroundColor: Colors.transparent,
                            child: CustomPopupCard(add: true),
                          ),
                        );
                      }));
                },
                child: Icon(
                  CommunityMaterialIcons.plus_thick,
                  color: AppTheme.addCardPlusColor,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Hero(tag: 'detail', child: CustomContainerCard()),
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                barrierDismissible: true,
                transitionDuration: Duration(seconds: 2),
                pageBuilder: (BuildContext context, _, __) {
                  return Hero(
                    tag: 'detail',
                    child: Dialog(
                      backgroundColor: Colors.transparent,
                      child: CustomPopupCard(add: false),
                    ),
                  );
                }));
          },
        ),
        CustomContainerCard(),
        CustomContainerCard(),
        CustomContainerCard(),
        CustomContainerCard(),
        CustomContainerCard(),
        CustomContainerCard(),
      ],
    );
    //   ],
    // );
  }
}
