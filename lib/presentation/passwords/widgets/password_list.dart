import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/presentation/core/custom_container_card.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add_popup.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_detail_popup.dart';
import 'package:password_safe/theme.dart';

class PasswordList extends StatelessWidget {
  final List<Password> passwordList;
  final double containerHeight = 190;
  final double containerWidth = 150;
  final double iconSize = 70;
  final int columnCount = 2;

  const PasswordList({super.key, required this.passwordList});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: columnCount,
        childAspectRatio: (containerWidth / containerHeight),
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
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: true,
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (BuildContext context, _, __) {
                              return Hero(
                                tag: 'add',
                                child: Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: PasswordAddPopup(
                                    password: null,
                                  ),
                                ),
                              );
                            }));
                      },
                      child: Container(
                        height: containerHeight,
                        width: containerWidth,
                        decoration: BoxDecoration(
                          color: AppTheme.addCardColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
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
        ]..addAll(
            passwordList.map(
              (password) => AnimationConfiguration.staggeredGrid(
                position: passwordList.indexOf(password) + 1,
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
                          )),
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: true,
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (BuildContext context, _, __) {
                              return Hero(
                                tag: password.id,
                                child: Dialog(
                                  backgroundColor: Colors.transparent,
                                  child:
                                      PasswordDetailPopup(password: password),
                                ),
                              );
                            }));
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
    //   ],
    // );
  }
}
