import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_safe/application/password/passwordForm/passwordform_bloc.dart';
import 'package:password_safe/theme.dart';

class FoldableButton extends StatefulWidget {
  final AnimationController controller;
  final List<AnimationController> animationControllers;
  const FoldableButton({
    super.key,
    required this.controller,
    required this.animationControllers,
  });

  @override
  _FoldableButtonState createState() => _FoldableButtonState();
}

class _FoldableButtonState extends State<FoldableButton>
    with TickerProviderStateMixin {
  bool isTapped = true;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return FoldableOptions(
      controller: widget.controller,
      animationControllers: widget.animationControllers,
    );
  }
}

class FoldableOptions extends StatefulWidget {
  final AnimationController controller;
  final List<AnimationController> animationControllers;

  const FoldableOptions(
      {super.key,
      required this.controller,
      required this.animationControllers});

  @override
  _FoldableOptionsState createState() => _FoldableOptionsState();
}

class _FoldableOptionsState extends State<FoldableOptions>
    with SingleTickerProviderStateMixin {
  final List<IconData> options = [
    CommunityMaterialIcons.heart,
    CommunityMaterialIcons.email,
    CommunityMaterialIcons.web,
  ];

  late Animation<EdgeInsetsGeometry> firstAnim;
  late Animation<EdgeInsetsGeometry> secondAnim;
  late Animation<EdgeInsetsGeometry> thirdAnim;
  // late AnimationController controller;
  final duration = Duration(milliseconds: 190);

  Widget getItem(IconData source, Color iconColor) {
    final size = 48.0;
    return GestureDetector(
      onTap: () {
        widget.controller.reverse();
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Icon(
          source,
          color: iconColor,
          size: 30,
        ),
      ),
    );
  }

  Widget buildPrimaryItem(IconData source) {
    final size = 48.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary,
            // blurRadius: verticalPadding.value
          ),
        ],
      ),
      child: Icon(
        source,
        color: Colors.white.withOpacity(1),
        size: 30,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // widget.controller = AnimationController(vsync: this, duration: duration);

    final anim =
        CurvedAnimation(parent: widget.controller, curve: Curves.linear);
    firstAnim = Tween<EdgeInsetsGeometry>(
            begin: EdgeInsets.only(top: 0), end: EdgeInsets.only(top: 50))
        .animate(anim);
    secondAnim = Tween<EdgeInsetsGeometry>(
            begin: EdgeInsets.only(top: 0), end: EdgeInsets.only(top: 100))
        .animate(anim);
    thirdAnim = Tween<EdgeInsetsGeometry>(
            begin: EdgeInsets.only(top: 0), end: EdgeInsets.only(top: 150))
        .animate(anim);
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: firstAnim.value,
                child: getItem(options.elementAt(0), AppTheme.tagHeartColor),
              ),
              Padding(
                padding: secondAnim.value,
                child: Container(
                  child: getItem(options.elementAt(1), AppTheme.tagEmailColor),
                ),
              ),
              Padding(
                padding: thirdAnim.value,
                child: getItem(options.elementAt(2), AppTheme.tagWebColor),
              ),
              GestureDetector(
                onTap: () {
                  widget.animationControllers.forEach((element) {
                    if (element != widget.controller) {
                      element.reverse();
                    }
                  });
                  widget.controller.isCompleted
                      ? widget.controller.reverse()
                      : widget.controller.forward();
                },
                child: buildPrimaryItem(
                  widget.controller.isCompleted || widget.controller.isAnimating
                      ? Icons.close
                      : Icons.add,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
