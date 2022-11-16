import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_detail.dart';

class CustomPopupCard extends StatelessWidget {
  final bool add;
  const CustomPopupCard({required this.add, super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double containerWidth = 320;
    final double containerHeight = 420;
    final double ellipseSize = 80;
    final double saveIconSize = 50;
    final double imagePlusSize = 80;

    return SingleChildScrollView(
      child: Container(
        width: containerWidth + 20,
        height: containerHeight + 20,
        child: Stack(
          children: [
            Center(
              child: Container(
                  width: containerWidth,
                  height: containerHeight,
                  decoration: BoxDecoration(
                    color: themeData.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: add ? PasswordAdd() : PasswordDetail(),
                  )),
            ),
            Positioned(
              right: 0,
              child: Container(
                height: ellipseSize,
                width: ellipseSize,
                decoration: BoxDecoration(
                  color: themeData.colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  add
                      ? CommunityMaterialIcons.content_save
                      : CommunityMaterialIcons.link_variant,
                  size: saveIconSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
