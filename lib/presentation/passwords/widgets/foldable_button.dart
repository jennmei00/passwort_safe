import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_safe/application/password/passwordTag/password_tag_bloc.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/theme.dart';
import 'package:password_safe/injection.dart';

class FoldableButton extends StatefulWidget {
  final AnimationController controller;
  final List<AnimationController> animationControllers;
  final Password password;
  const FoldableButton({
    super.key,
    required this.controller,
    required this.animationControllers,
    required this.password,
  });

  @override
  _FoldableButtonState createState() => _FoldableButtonState();
}

class _FoldableButtonState extends State<FoldableButton>
    with TickerProviderStateMixin {
  bool isTapped = true;
  bool isExpanded = false;

  final List<IconData> options = [
    CommunityMaterialIcons.heart,
    CommunityMaterialIcons.email,
    CommunityMaterialIcons.web,
  ];

  late Animation<EdgeInsetsGeometry> firstAnim;
  late Animation<EdgeInsetsGeometry> secondAnim;
  late Animation<EdgeInsetsGeometry> thirdAnim;
  final duration = Duration(milliseconds: 190);

  Icon getIcon() {
    Icon icon = Icon(CommunityMaterialIcons.plus,
        color: Colors.white.withOpacity(1), size: 30);

    int countTags = 0;

    if (widget.password.favTag) {
      countTags += 1;
    }
    if (widget.password.emailTag) {
      countTags += 1;
    }
    if (widget.password.webTag) {
      countTags += 1;
    }

    if (countTags > 1) {
      icon = Icon(CommunityMaterialIcons.numeric_1_box_multiple,
          color: Colors.white.withOpacity(1), size: 30);
    } else if (countTags == 1) {
      if (widget.password.favTag) {
        icon = Icon(CommunityMaterialIcons.heart,
            color: AppTheme.tagHeartColor, size: 30);
      } else if (widget.password.emailTag) {
        icon = Icon(CommunityMaterialIcons.email,
            color: AppTheme.tagEmailColor, size: 30);
      } else if (widget.password.webTag) {
        icon = Icon(CommunityMaterialIcons.web,
            color: AppTheme.tagWebColor, size: 30);
      }
    }

    return icon;
  }

  Widget getItem(
      IconData source, Color iconColor, BuildContext context, int tag) {
    final size = 48.0;
    bool addTag = false;
    List<Shadow> shadows = [];

    //tag description:
    //1: heart
    //2: email
    //3: web

    if (widget.controller.isCompleted) {
      switch (tag) {
        case 1:
          if (widget.password.favTag) {
            shadows.add(
                Shadow(color: iconColor, blurRadius: 40, offset: Offset(3, 3)));
            shadows.add(Shadow(
                color: iconColor, blurRadius: 40, offset: Offset(-3, -3)));
          }
          break;
        case 2:
          if (widget.password.emailTag) {
            shadows.add(
                Shadow(color: iconColor, blurRadius: 40, offset: Offset(3, 3)));
            shadows.add(Shadow(
                color: iconColor, blurRadius: 40, offset: Offset(-3, -3)));
          }
          break;
        case 3:
          if (widget.password.webTag) {
            shadows.add(
                Shadow(color: iconColor, blurRadius: 40, offset: Offset(3, 3)));
            shadows.add(Shadow(
                color: iconColor, blurRadius: 40, offset: Offset(-3, -3)));
          }
          break;
        default:
      }
    }

    return GestureDetector(
      onTap: () {
        switch (tag) {
          case 1:
            addTag = !widget.password.favTag;
            break;
          case 2:
            addTag = !widget.password.emailTag;
            break;
          case 3:
            addTag = !widget.password.webTag;
            break;
          default:
        }
        BlocProvider.of<PasswordTagBloc>(context)
            .add(InitializePassword(password: widget.password));
        BlocProvider.of<PasswordTagBloc>(context)
            .add(TagPressedEvent(tag: tag, addTag: addTag));
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
          shadows: shadows,
        ),
      ),
    );
  }

  Widget buildPrimaryItem(Icon icon) {
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
          ),
        ],
      ),
      child: icon,
    );
  }

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PasswordTagBloc>(),
      child: BlocConsumer<PasswordTagBloc, PasswordTagState>(
        listenWhen: (previous, current) =>
            previous.failureOrSuccessOption != current.failureOrSuccessOption,
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
              () => null,
              (eitherFailureOrSuccess) =>
                  eitherFailureOrSuccess.fold((failure) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Etwas ist schiefgelaufen :("),
                        backgroundColor: Colors.redAccent));
                  }, (_) => null));
        },
        builder: (context, state) {
          return Container(
            width: 48,
            child: AnimatedBuilder(
              animation: widget.controller,
              builder: (context, child) {
                return Stack(
                  children: <Widget>[
                    Padding(
                      padding: Tween<EdgeInsetsGeometry>(
                              begin: EdgeInsets.only(top: 0),
                              end: EdgeInsets.only(top: 50))
                          .animate(widget.controller)
                          .value,
                      child: getItem(
                        options.elementAt(0),
                        AppTheme.tagHeartColor,
                        context,
                        1,
                      ),
                    ),
                    Padding(
                      padding: Tween<EdgeInsetsGeometry>(
                              begin: EdgeInsets.only(top: 0),
                              end: EdgeInsets.only(top: 100))
                          .animate(widget.controller)
                          .value,
                      child: Container(
                        child: getItem(
                          options.elementAt(1),
                          AppTheme.tagEmailColor,
                          context,
                          2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: Tween<EdgeInsetsGeometry>(
                              begin: EdgeInsets.only(top: 0),
                              end: EdgeInsets.only(top: 150))
                          .animate(widget.controller)
                          .value,
                      child: getItem(
                        options.elementAt(2),
                        AppTheme.tagWebColor,
                        context,
                        3,
                      ),
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
                        widget.controller.isCompleted ||
                                widget.controller.isAnimating
                            ? Icon(Icons.close)
                            : getIcon(),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
