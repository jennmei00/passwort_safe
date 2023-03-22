import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/presentation/passwords/password_overview_page.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return PasswordOverViewPage();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print('HEEEEEERE');
        print(state);
        if (state is AuthStateAuthenticated) {
          // navigate to home
          context.router.replace(const PasswordOverViewPageRoute());
        } else if (state is AuthStateUnauthenticated) {
          // navigate to signin
          context.router.replace(const SignUpPageRoute());
        } else if(state is AuthStateTryLogin) {
          //navigate to login
          context.router.replace(LoginPageRoute(user: state.userModel));
        }
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
