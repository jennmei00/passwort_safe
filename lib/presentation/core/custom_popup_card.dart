import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class CustomPopupCard extends StatelessWidget {
  final bool add;
  final Function buttonPressed;
  final Widget child;
  const CustomPopupCard(
      {required this.add,
      required this.buttonPressed,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double containerWidth = 320;
    final double containerHeight = 440;
    final double ellipseSize = 70;
    final double saveIconSize = 40;

    return FractionallySizedBox(
      widthFactor: 0.95,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Container(
          height: 500,
          child: Stack(
            children: [
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    height: containerHeight,
                    decoration: BoxDecoration(
                      color: themeData.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: child,
                  ),
                ),
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
                    child: IconButton(
                      icon: Icon(
                        add
                            ? CommunityMaterialIcons.content_save
                            : CommunityMaterialIcons.link_variant,
                        size: saveIconSize,
                      ),
                      onPressed: () => buttonPressed(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
