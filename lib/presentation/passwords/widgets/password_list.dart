import 'dart:ui';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/presentation/core/custom_container_card.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add_popup.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_detail_popup.dart';
import 'package:password_safe/theme.dart';
import 'package:password_safe/presentation/passwords/globals.dart' as globals;

class PasswordList extends StatefulWidget {
  final List<Password> passwordList;

  const PasswordList({super.key, required this.passwordList});

  @override
  State<PasswordList> createState() => _PasswordListState();
}

class _PasswordListState extends State<PasswordList>
    with TickerProviderStateMixin {
  final double containerHeight = 190;
  final List<Password> showPasswordList = [];

  final double containerWidth = 150;

  final double iconSize = 70;
  // late AnimationController foldableButtonAnimationController;
  late List<AnimationController> animationControllers = [];

  @override
  void initState() {
    fillShowPasswordList();

    globals.filterTag.addListener(() {
      setState(() {
        fillShowPasswordList();
      });
    });

    globals.searchQuery.addListener(() {
      setState(() {
        fillShowPasswordList();
      });
    });

    widget.passwordList.forEach((element) {
      animationControllers.add(AnimationController(
          vsync: this, duration: Duration(milliseconds: 300)));
    });

    super.initState();
  }

  void fillShowPasswordList() {
    //TODO: Filter optimieren
    showPasswordList.clear();
    if (globals.searchQuery.value == '') {
      if (globals.filterTag.value == 0) {
        showPasswordList.addAll(widget.passwordList);
      } else {
        widget.passwordList.forEach((element) {
          switch (globals.filterTag.value) {
            case 1:
              if (element.favTag) {
                showPasswordList.add(element);
              }
              break;
            case 2:
              if (element.emailTag) {
                showPasswordList.add(element);
              }
              break;
            case 3:
              if (element.webTag) {
                showPasswordList.add(element);
              }
              break;
            default:
              break;
          }
        });
      }
    } else {
      widget.passwordList.forEach((element) {
        if (element.title.startsWith(globals.searchQuery.value) &&
            !showPasswordList.contains(element)) {
          showPasswordList.add(element);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    int columnCount = (mediaWidth / (containerWidth + 40)).round();
    final controllerBloc = context.read<ControllerBloc>();

    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: columnCount,
        childAspectRatio: (containerWidth / containerHeight),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          AnimationConfiguration.staggeredGrid(
            position: 0,
            columnCount: columnCount,
            duration: Duration(milliseconds: 500),
            child: ScaleAnimation(
              duration: Duration(milliseconds: 900),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                child: Hero(
                  tag: 'add',
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        animationControllers
                            .forEach((element) => element.reverse());
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: true,
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (BuildContext context, _, __) {
                              return Hero(
                                tag: 'add',
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Dialog(
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    child: PasswordAddPopup(
                                      password: null,
                                    ),
                                  ),
                                ),
                              );
                            }));
                      },
                      child: Card(
                        elevation: 5,
                        color: AppTheme.addCardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: SizedBox(
                          height: containerHeight,
                          width: containerWidth,
                          child: Icon(
                            CommunityMaterialIcons.plus_thick,
                            color: AppTheme.addCardPlusColor,
                            size: iconSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]..addAll(
            showPasswordList.map((password) {
              return AnimationConfiguration.staggeredGrid(
                position: widget.passwordList.indexOf(password) + 1,
                columnCount: columnCount,
                duration: Duration(milliseconds: 500),
                child: ScaleAnimation(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      child: Hero(
                          tag: password.id,
                          child: CustomContainerCard(
                            password: password,
                            foldableButtonAnimationController:
                                animationControllers[widget.passwordList
                                    .indexWhere(
                                        (element) => element == password)],
                            animationControllers: animationControllers,
                          )),
                      onTap: () {
                        animationControllers.forEach((element) {
                          element.reverse();
                        });
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: true,
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (BuildContext context, _, __) {
                              return Hero(
                                tag: password.id,
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.zero,
                                    child: PasswordDetailPopup(
                                      password: password,
                                      controllerBloc: controllerBloc,
                                    ),
                                  ),
                                ),
                              );
                            }));
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
      ),
    );
    //   ],
    // );
  }
}
