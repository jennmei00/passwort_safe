import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class CustomPopupCard extends StatelessWidget {
  final bool add;
  final IconData? icon;
  final Function? buttonPressed;
  final Widget child;
  const CustomPopupCard(
      {required this.add,
      required this.icon,
      required this.buttonPressed,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double ellipseSize = 70;
    final double saveIconSize = 40;

    return FractionallySizedBox(
      widthFactor: 0.95,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Container(
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95 - 30,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.symmetric(vertical: 20),
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
                        add ? CommunityMaterialIcons.content_save : icon,
                        size: saveIconSize,
                      ),
                      onPressed:
                          buttonPressed == null ? null : () => buttonPressed!(),
                      disabledColor: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
