import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/presentation/passwords/password_overview_page.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listenWhen: (previous, current) {
      return previous != current;
    }, listener: (context, state) {
      if (state is AuthStateUnauthenticated) {
        // navigate to signin
        context.router.replace(const SignUpRoute());
      } else if (state is AuthStateTryLogin) {
        //navigate to login
        context.router.replace(LoginRoute(user: state.userModel));
      }
    }, builder: (context, state) {
      return state is AuthStateAuthenticated
          ? PasswordOverViewPage(user: state.userModel)
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
    });
  }
}
