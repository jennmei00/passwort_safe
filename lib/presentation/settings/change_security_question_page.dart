import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/settings/widgets/change_security_question_form.dart';

class ChangeSecurityQuestionPage extends StatefulWidget {
  final UserModel user;
  const ChangeSecurityQuestionPage({super.key, required this.user});

  @override
  State<ChangeSecurityQuestionPage> createState() =>
      _ChangeSecurityQuestionPageState();
}

class _ChangeSecurityQuestionPageState
    extends State<ChangeSecurityQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return PlatformScaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    PlatformIconButton(
                      materialIcon:
                          Icon(CommunityMaterialIcons.arrow_left_bold),
                      cupertinoIcon: Icon(CupertinoIcons.back),
                      onPressed: () => AutoRouter.of(context).pop(),
                    ),
                    Text('     Sicherheitsfrage ändern')
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          color: themeData.primaryColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child:
                                ChangeSecurityQuestionForm(user: widget.user),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
