import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_safe/application/password/passwordForm/passwordform_bloc.dart';
import 'package:password_safe/presentation/core/custom_text_field.dart';

class PasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController textEditingControllerTitle;
  final TextEditingController textEditingControllerName;
  final TextEditingController textEditingControllerEmail;
  final TextEditingController textEditingControllerPassword;
  final TextEditingController textEditingControllerLink;

  const PasswordForm({
    required this.formKey,
    required this.textEditingControllerTitle,
    required this.textEditingControllerName,
    required this.textEditingControllerEmail,
    required this.textEditingControllerPassword,
    required this.textEditingControllerLink,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double imagePlusSize = 80;

    // late String title;
    // late String name;
    // late String email;
    // late String password;
    // late String link;

    String? validateFields(String? input) {
      if (input == null || input.isEmpty) {
        return 'Bitte Daten eingeben';
      } else if (input.length < 30) {
        // title = input;
        return null;
      } else {
        return "Text zu lang";
      }
    }

    return BlocConsumer<PasswordformBloc, PasswordformState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        textEditingControllerTitle.text = state.password.title;
        textEditingControllerName.text = state.password.name;
        textEditingControllerEmail.text = state.password.email;
        textEditingControllerPassword.text = state.password.password;
        textEditingControllerLink.text = state.password.link;
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(children: [
            Row(
              children: [
                Flexible(
                  child: Icon(
                    CommunityMaterialIcons.image_plus,
                    size: imagePlusSize,
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: SizedBox(
                    width: 90,
                    child: TextFormField(
                      validator: validateFields,
                      controller: textEditingControllerTitle,
                      maxLines: 2,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Titel...'),
                      style: themeData.textTheme.headline1,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(thickness: 2),
            ),
            CustomTextField(
                label: 'NAME',
                validator: validateFields,
                controller: textEditingControllerName),
            CustomTextField(
              label: 'E-MAIL',
              validator: validateFields,
              controller: textEditingControllerEmail,
            ),
            CustomTextField(
              label: 'PASSWORT',
              validator: validateFields,
              controller: textEditingControllerPassword,
            ),
            CustomTextField(
              label: 'VERKNÜPFUNG',
              validator: validateFields,
              controller: textEditingControllerLink,
            ),
          ]),
        );
      },
    );
  }
}
