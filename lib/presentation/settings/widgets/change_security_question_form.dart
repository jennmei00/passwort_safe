import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/core/enums.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';

class ChangeSecurityQuestionForm extends StatefulWidget {
  final UserModel user;
  const ChangeSecurityQuestionForm({super.key, required this.user});

  @override
  State<ChangeSecurityQuestionForm> createState() =>
      _ChangeSecurityQuestionFormState();
}

class _ChangeSecurityQuestionFormState
    extends State<ChangeSecurityQuestionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController newAnswer = TextEditingController();
  int dropdownValue = 0;
  double answerHeight = 40;

  String? validateAnswer(String? input) {
    if (input == null || input.isEmpty) {
      setState(() {
        answerHeight = 60;
      });
      return 'Bitte Antwort eingeben';
    } else {
      setState(() {
        answerHeight = 40;
      });
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.user.securityQuestionIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<int>(
                value: dropdownValue,
                underline: Container(),
                isExpanded: true,
                items: SecurityQuestion.values
                    .map((e) => DropdownMenuItem(
                        value: e.index,
                        child: Text(
                          e.value,
                          overflow: TextOverflow.visible,
                        )))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    dropdownValue = val!;
                  });
                }),
          ),
          CustomTextField(
            label: 'Antwort',
            controller: newAnswer,
            validator: validateAnswer,
            textFieldHeight: answerHeight,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlatformElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        BlocProvider.of<AuthBloc>(context)
                            .add(ChangeSecurityQuestionPressedEvent(
                          user: widget.user,
                          newAnswer: newAnswer.text,
                          newQuestionIndex: dropdownValue,
                        ));
                        context.router
                            .removeUntil((route) => route == SplashPageRoute());
                        context.router.push(const SplashPageRoute());
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ändern',
                      style: TextStyle(
                          color: Colors.redAccent.withOpacity(0.5),
                          fontSize: 20),
                    ),
                  ),
                  material: (context, platform) => MaterialElevatedButtonData(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
