import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_safe/application/password/passwordForm/passwordform_bloc.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/presentation/passwords/widgets/custom_popup_card.dart';
import 'package:password_safe/injection.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_form.dart';
import 'package:password_safe/presentation/passwords/widgets/safe_progress_overlay.dart';

class PasswordAddPopup extends StatefulWidget {
  final Password? password;
  const PasswordAddPopup({super.key, required this.password});

  @override
  State<PasswordAddPopup> createState() => _PasswordAddPopupState();
}

class _PasswordAddPopupState extends State<PasswordAddPopup> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final textEditingControllerTitle = TextEditingController();
  final textEditingControllerName = TextEditingController();
  final textEditingControllerEmail = TextEditingController();
  final textEditingControllerPassword = TextEditingController();
  final textEditingControllerInfo = TextEditingController();

  IconData iconData = CommunityMaterialIcons.cart;

  void loadInit() {
    // icon = widget.password!.icon;
    if (widget.password != null) {
      textEditingControllerTitle.text = widget.password!.title;
      textEditingControllerName.text = widget.password!.name;
      textEditingControllerEmail.text = widget.password!.email;
      textEditingControllerPassword.text = widget.password!.password;
      textEditingControllerInfo.text = widget.password!.info;
    }
  }

  @override
  void initState() {
    if (widget.password != null) {
      iconData = widget.password!.icon;
    }
    loadInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<PasswordformBloc>()
          ..add(InitializePasswordDetailContainer(password: widget.password)),
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
                            content: Text("Ein Fehler ist aufgetreten :("),
                            backgroundColor: Colors.redAccent)),
                    (_) => Navigator.of(context).pop()));
          },
          builder: (context, state) {
            return CustomPopupCard(
              add: true,
              icon: null,
              buttonPressed: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<PasswordformBloc>(context).add(
                    SafePressedEvent(
                      title: textEditingControllerTitle.text,
                      name: textEditingControllerName.text,
                      email: textEditingControllerEmail.text,
                      passwordText: textEditingControllerPassword.text,
                      icon: iconData,
                      info: textEditingControllerInfo.text,
                    ),
                  );
                  // } else {

                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       backgroundColor: Colors.redAccent,
                  //       content: Text(
                  //         "Invalid Input",
                  //         style: Theme.of(context).textTheme.bodyText1,
                  //       )));
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
                      textEditingControllerInfo: textEditingControllerInfo,
                      iconPressed: (icon) {
                        setState(() {
                          iconData = icon;
                          loadInit();
                        });

                        Navigator.of(context).pop();
                      },
                      icon: iconData,
                      randomPassPressed: () {
                        print('RAndomPassword');
                        // setState(() {
                        // textEditingControllerPassword.text =
                        //     'RandomPwasswordGenerated';
                        // });
                      }),
                  SafeInProgressOverlay(isSaving: state.isSaving),
                ],
              ),
            );
          },
        ));
  }
}
