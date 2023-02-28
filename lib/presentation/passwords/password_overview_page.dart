import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/application/password/observer/observer_bloc.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/passwords/widgets/password_overview_body.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/theme.dart';
import 'package:password_safe/injection.dart';

class PasswordOverViewPage extends StatelessWidget {
  const PasswordOverViewPage({super.key});

  String _mapFailureToMessage(PasswordFailure todoFailure) {
    switch (todoFailure.runtimeType) {
      case DBFailure:
        return "Das Lesen aus der Datenbank ist nicht möglich";

      default:
        return "Etwas ist schiefgelaufen";
    }
  }

  @override
  Widget build(BuildContext context) {
    final observerBloc = sl<ObserverBloc>()..add(GetAllEvent());

    return MultiBlocProvider(
      providers: [
        BlocProvider<ObserverBloc>(
          create: (context) => observerBloc,
        ),
        BlocProvider<ControllerBloc>(
          create: ((context) => sl<ControllerBloc>()),
        )
      ],
      child: BlocListener<ControllerBloc, ControllerState>(
        listener: (context, state) {
          if (state is ControllerFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(_mapFailureToMessage(state.passwordFailure))));
          }
        },
        child: PlatformScaffold(
          body: BackgroundContainer(
              child: Stack(children: [
            PasswordOverViewBody(),
            Positioned(
                right: 0,
                bottom: 0,
                child: SizedBox(
                    height: 70,
                    width: 70,
                    child: FloatingActionButton(
                        onPressed: () {
                          AutoRouter.of(context)
                              .push(const SettingsPageRoute());
                        },
                        child: Icon(
                          CommunityMaterialIcons.cog,
                          size: 40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                          ),
                        )))),
          ])),
        ),
      ),
    );
  }
}
