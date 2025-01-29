import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/application/password/observer/observer_bloc.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/infrastructure/models/user_model.dart';
import 'package:password_safe/presentation/core/backgroundContainer.dart';
import 'package:password_safe/presentation/passwords/widgets/password_overview_body.dart';
import 'package:password_safe/presentation/passwords/globals.dart' as globals;
import 'package:password_safe/injection.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../application/auth/authbloc/auth_bloc.dart';

@RoutePage()
class PasswordOverViewPage extends StatefulWidget {
  final UserModel user;

  const PasswordOverViewPage({super.key, required this.user});

  @override
  State<PasswordOverViewPage> createState() => _PasswordOverViewPageState();
}

class _PasswordOverViewPageState extends State<PasswordOverViewPage>
    with WidgetsBindingObserver {
  String _mapFailureToMessage(PasswordFailure todoFailure) {
    switch (todoFailure.runtimeType) {
      case DBFailure:
        return "Das Lesen aus der Datenbank ist nicht möglich";

      default:
        return "Etwas ist schiefgelaufen";
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                bottom: 5,
                left: 5,
                child: FloatingActionButton(
                  heroTag: 'grid_listview',
                  onPressed: () {
                    setState(() {
                      globals.isGrid = !globals.isGrid;
                    });
                    SharedPreferences.getInstance().then(
                        (value) => value.setBool('isGrid', globals.isGrid));
                  },
                  backgroundColor: AppTheme.darkTheme.primaryColor,
                  child: Icon(
                    globals.isGrid
                        ? CommunityMaterialIcons.view_list
                        : CommunityMaterialIcons.grid,
                    color: Colors.white,
                  ),
                  elevation: 5,
                  splashColor: Theme.of(context).colorScheme.secondary,
                )),
            Positioned(
              right: 5,
              bottom: 5,
              child: SizedBox(
                child: FloatingActionButton(
                  heroTag: 'settings',
                  onPressed: () {
                    AutoRouter.of(context)
                        .push(SettingsRoute(user: widget.user));
                  },
                  child: Icon(
                    CommunityMaterialIcons.cog,
                    size: 40,
                    color: Colors.black,
                  ),
                  backgroundColor: Color.fromARGB(255, 123, 135, 173),
                  splashColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ])),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.hidden) {
      try {
        BlocProvider.of<AuthBloc>(context)
            .add(AuthLoggedOutEvent(user: widget.user));
        context.router.removeUntil((route) => route == SplashRoute());
        context.router.push(const SplashRoute());
      } catch (e) {
        print(e);
      }
    }
  }
}
