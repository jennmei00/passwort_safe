import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/theme.dart';

class ChangeNameForm extends StatefulWidget {
  final UserModel user;
  const ChangeNameForm({super.key, required this.user});

  @override
  State<ChangeNameForm> createState() => _ChangeNameFormState();
}

class _ChangeNameFormState extends State<ChangeNameForm> {
  TextEditingController controller = TextEditingController();
  double textFieldHeight = 40;
  bool editName = false;
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value == '') {
      textFieldHeight = 60;

      return 'Bitte Name angeben';
    } else {
      return null;
    }
  }

  @override
  void initState() {
    controller.text = widget.user.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: nameKey,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'NAME',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  height: textFieldHeight,
                  decoration: BoxDecoration(
                      gradient: AppTheme.textFieldGradient,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                            padding: EdgeInsets.only(right: 2),
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: (() {
                                if (!editName) {
                                  setState(() => editName = !editName);
                                } else {
                                  if (nameKey.currentState!.validate()) {
                                    try {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          ChangeNamePressedEvent(
                                              user: widget.user,
                                              newName: controller.text));
                                      context.router.removeUntil((route) =>
                                          route == SplashPageRoute());
                                      context.router
                                          .push(const SplashPageRoute());
                                    } catch (e) {
                                      print(e);
                                    }
                                  } else {
                                    setState(() {});
                                  }
                                }
                              }),
                              icon: Icon(!editName
                                  ? CommunityMaterialIcons.pencil
                                  : CommunityMaterialIcons.content_save),
                            )),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: textFieldHeight),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              cursorColor:
                                  Theme.of(context).colorScheme.secondary,
                              enabled: editName,
                              validator: (value) => validator(value),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              controller: controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isCollapsed: true,
                              ),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
