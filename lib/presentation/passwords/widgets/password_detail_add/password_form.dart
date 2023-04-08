import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/password/passwordForm/passwordform_bloc.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';
import 'package:password_safe/presentation/passwords/widgets/icon_container_card.dart';

class PasswordForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController textEditingControllerTitle;
  final TextEditingController textEditingControllerName;
  final TextEditingController textEditingControllerEmail;
  final TextEditingController textEditingControllerPassword;
  final TextEditingController textEditingControllerLink;
  final TextEditingController textEditingControllerInfo;
  final Function iconPressed;
  final IconData icon;

  const PasswordForm({
    required this.formKey,
    required this.textEditingControllerTitle,
    required this.textEditingControllerName,
    required this.textEditingControllerEmail,
    required this.textEditingControllerPassword,
    required this.textEditingControllerLink,
    required this.textEditingControllerInfo,
    required this.iconPressed,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  double textFieldHeight = 40;
  double nameHeight = 40;
  double emailHeight = 40;
  double passowrdHeight = 40;

  String? validateTitle(String? input) {
    if (input == null || input.isEmpty) {
      return 'Bitte Titel eingeben';
    } else if (input.length > 30) {
      return "Der Titel ist zu lang";
    } else {
      return null;
    }
  }

  String? validateName(String? input) {
    if (input == null || input.isEmpty) {
      setState(() {
        nameHeight = 60;
      });
      return 'Bitte Name eingeben';
    } else {
      setState(() {
        nameHeight = 40;
      });
      return null;
    }
  }

  String? validateEmail(String? input) {
    if (input == null || input.isEmpty) {
      setState(() {
        emailHeight = 60;
      });
      return 'Bitte E-Mail eingeben';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input)) {
      setState(() {
        emailHeight = 60;
      });
      return "Bitte gültige E-Mail eingeben";
    } else {
      setState(() {
        emailHeight = 40;
      });
      return null;
    }
  }

  String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      setState(() {
        passowrdHeight = 60;
      });
      return 'Bitte Passwort eingeben';
    } else {
      setState(() {
        passowrdHeight = 40;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double imagePlusSize = 70;

    return BlocConsumer<PasswordformBloc, PasswordformState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        widget.textEditingControllerTitle.text = state.password.title;
        widget.textEditingControllerName.text = state.password.name;
        widget.textEditingControllerEmail.text = state.password.email;
        widget.textEditingControllerPassword.text = state.password.password;
        widget.textEditingControllerLink.text = state.password.link;
      },
      builder: (context, state) {
        return Form(
          key: widget.formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 50.0, left: 5.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showPlatformDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              child: IconContainerCard(
                                icon: widget.icon,
                                iconPressed: (icon) => widget.iconPressed(icon),
                              ),
                            );
                          });
                    },
                    icon: Icon(widget.icon),
                    iconSize: imagePlusSize,
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      validator: validateTitle,
                      controller: widget.textEditingControllerTitle,
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Titel...',
                      ),
                      style: themeData.textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(thickness: 2),
            ),
            CustomTextField(
              textFieldHeight: nameHeight,
              label: 'NAME',
              validator: validateName,
              controller: widget.textEditingControllerName,
            ),
            CustomTextField(
              textFieldHeight: emailHeight,
              label: 'E-MAIL',
              validator: validateEmail,
              controller: widget.textEditingControllerEmail,
            ),
            CustomTextField(
              textFieldHeight: passowrdHeight,
              label: 'PASSWORT',
              validator: validatePassword,
              controller: widget.textEditingControllerPassword,
            ),
            CustomTextField(
              label: 'VERKNÜPFUNG',
              controller: widget.textEditingControllerLink,
            ),
            CustomTextField(
              label: 'INFO',
              controller: widget.textEditingControllerInfo,
            ),
          ]),
        );
      },
    );
  }
}
