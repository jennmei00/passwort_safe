import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/presentation/core/custom_container_card.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add_popup.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_detail_popup.dart';
import 'package:password_safe/theme.dart';

class PasswordList extends StatelessWidget {
  final List<Password> passwordList;

  const PasswordList({super.key, required this.passwordList});

  @override
  Widget build(BuildContext context) {
    final double containerHeight = 190;
    final double containerWidth = 150;
    final double iconSize = 70;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (containerWidth / containerHeight),
      children: [
        Hero(
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
      ]..addAll(
          passwordList.map(
            (password) => GestureDetector(
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
                          child: PasswordDetailPopup(password: password),
                        ),
                      );
                    }));
              },
            ),
          ),
        ),
    );
    //   ],
    // );
  }
}
