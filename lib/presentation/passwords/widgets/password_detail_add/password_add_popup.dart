import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_safe/application/password/passwordForm/passwordform_bloc.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/presentation/core/custom_popup_card.dart';
import 'package:password_safe/injection.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_form.dart';
import 'package:password_safe/presentation/passwords/widgets/safe_progress_overlay.dart';

class PasswordAddPopup extends StatelessWidget {
  final Password? password;
  const PasswordAddPopup({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final textEditingControllerTitle = TextEditingController();
    final textEditingControllerName = TextEditingController();
    final textEditingControllerEmail = TextEditingController();
    final textEditingControllerPassword = TextEditingController();
    final textEditingControllerLink = TextEditingController();

    return BlocProvider(
        create: (context) => sl<PasswordformBloc>()
          ..add(InitializePasswordDetailContainer(password: password)),
        child: BlocConsumer<PasswordformBloc, PasswordformState>(
          listenWhen: ((previous, current) =>
              previous.failureOrSuccessOption !=
              current.failureOrSuccessOption),
          listener: (context, state) {
            state.failureOrSuccessOption.fold(
                () {},
                (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
                    (Failure) => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("failure"),
                            backgroundColor: Colors.redAccent)),
                    (_) => Navigator.of(context).pop()));
          },
          builder: (context, state) {
            return CustomPopupCard(
              add: true,
              buttonPressed: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<PasswordformBloc>(context).add(
                    SafePressedEvent(
                      title: textEditingControllerTitle.text,
                      name: textEditingControllerName.text,
                      email: textEditingControllerEmail.text,
                      passwordText: textEditingControllerPassword.text,
                      link: textEditingControllerLink.text,
                      icon: CommunityMaterialIcons.cart,
                      tags: [],
                    ),
                    
                  );
                } else {
                  // BlocProvider.of<PasswordformBloc>(context)
                  //     .add(SafePressedEvent(
                  //   title: null,
                  //   name: null,
                  //   email: null,
                  //   passwordText: null,
                  //   link: null,
                  //   icon: null,
                  //   tags: null,
                  // ));

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        "Invalid Input",
                        style: Theme.of(context).textTheme.bodyText1,
                      )));
                }
                ;
              },
              child: Stack(
                children: [
                  PasswordForm(
                    formKey: formKey,
                    textEditingControllerTitle: textEditingControllerTitle,
                    textEditingControllerName: textEditingControllerName,
                    textEditingControllerEmail: textEditingControllerEmail,
                    textEditingControllerPassword:
                        textEditingControllerPassword,
                    textEditingControllerLink: textEditingControllerLink,
                  ),
                  SafeInProgressOverlay(isSaving: state.isSaving),
                ],
              ),
            );
          },
        ));
  }
}
