import 'package:flutter/material.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/presentation/passwords/widgets/foldable_button.dart';

class CustomContainerCard extends StatelessWidget {
  final Password password;
  final AnimationController foldableButtonAnimationController;
  final List<AnimationController> animationControllers;
  CustomContainerCard({
    required this.password,
    required this.foldableButtonAnimationController,
    required this.animationControllers,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double containerHeight = 190;
    final double containerWidth = 150;
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
                      style: themeData.textTheme.bodyMedium,
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
              password: password,
            ),
          ),
        ],
      ),
    );
  }
}
