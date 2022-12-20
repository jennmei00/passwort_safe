import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/application/password/observer/observer_bloc.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/presentation/passwords/widgets/password_overview_body.dart';
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
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AppTheme.backgroundImage, fit: BoxFit.fill),
              ),
              child: PasswordOverViewBody()),
        ),
      ),
    );
  }
}
