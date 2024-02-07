import 'dart:ui';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/infrastructure/datasources/db_local_datasource.dart';
import 'package:password_safe/infrastructure/models/password_model.dart';
import 'package:password_safe/presentation/passwords/widgets/foldable_button.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add_popup.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_detail_popup.dart';
import 'package:password_safe/theme.dart';
import 'package:password_safe/presentation/passwords/globals.dart' as globals;

class PasswordListListView extends StatefulWidget {
  final List<Password> passwordList;

  const PasswordListListView({super.key, required this.passwordList});

  @override
  State<PasswordListListView> createState() => _PasswordListListViewState();
}

class _PasswordListListViewState extends State<PasswordListListView>
    with TickerProviderStateMixin {
  final double containerHeight = 190;
  final List<Password> showPasswordList = [];

  final double containerWidth = 150;

  final double iconSize = 70;
  late List<AnimationController> animationControllers = [];

  @override
  void initState() {
    refreshList();

    super.initState();
  }

  void refreshList() {
    fillShowPasswordList();

    globals.passwordLength = widget.passwordList.length;

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
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = widget.passwordList.removeAt(oldIndex);
      widget.passwordList.insert(newIndex, item);
      final item2 = showPasswordList.removeAt(oldIndex);
      showPasswordList.insert(newIndex, item2);
    });
    DBLocalDatasourceImpl().delete('Password');
    DBLocalDatasourceImpl().multipleInsert(
        'Password',
        widget.passwordList
            .map((e) => PasswordModel.fromDomain(e).toMap())
            .toList());
  }

  void fillShowPasswordList() {
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
        if (element.title
                .toLowerCase()
                .startsWith(globals.searchQuery.value.toLowerCase()) &&
            !showPasswordList.contains(element)) {
          showPasswordList.add(element);
        }
      });
    }
    globals.showPasswordLength = showPasswordList.length;
  }

  @override
  Widget build(BuildContext context) {
    final controllerBloc = context.read<ControllerBloc>();
    refreshList();

    return AnimationLimiter(
      child: ReorderableListView(
        onReorder: _onReorder,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 70),
        header: AnimationConfiguration.staggeredList(
          position: 0,
          duration: Duration(milliseconds: 500),
          key: ValueKey('ADD_CARD'),
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
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                      color: AppTheme.addCardColor,
                      elevation: 5,
                      child: ListTile(
                          title: Icon(CommunityMaterialIcons.plus_thick,
                              color: AppTheme.addCardPlusColor)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        children: showPasswordList
            .map(
              (password) => AnimationConfiguration.staggeredList(
                position: widget.passwordList.indexOf(password) + 1,
                duration: Duration(milliseconds: 500),
                key: ValueKey(password),
                child: ScaleAnimation(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      child: Hero(
                        tag: password.id,
                        child: Card(
                          color: AppTheme.darkTheme.primaryColor,
                          elevation: 5,
                          child: ListTile(
                            leading: Icon(password.icon),
                            title: Text(password.title),
                            trailing: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FoldableButton(
                                controller: animationControllers[
                                    widget.passwordList.indexWhere(
                                        (element) => element == password)],
                                animationControllers: animationControllers,
                                password: password,
                                isGrid: globals.isGrid,
                              ),
                            ),
                          ),
                        ),
                      ),
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
              ),
            )
            .toList(),
      ),
    );
  }
}
