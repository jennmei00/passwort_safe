import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_safe/application/auth/authbloc/auth_bloc.dart';
import 'package:password_safe/presentation/routes/router.gr.dart';
import 'package:password_safe/presentation/passwords/password_overview_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  // Future<void> deleteUserPrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  // }

  @override
  Widget build(BuildContext context) {
    // deleteUserPrefs();
    print('Load SplashScreen');
    // return PasswordOverViewPage();
    return BlocConsumer<AuthBloc, AuthState>(listenWhen: (previous, current) {
      print('LISTENWHEN');
      print(previous);
      print(current);
      return previous != current;
    }, listener: (context, state) {
      print('HEEEEEERE');
      print(state);
      // if (state is AuthStateAuthenticated) {
      //   // navigate to home
      //   context.router
      //       .replace(PasswordOverViewPageRoute(user: state.userModel));
      // } else
       if (state is AuthStateUnauthenticated) {
        // navigate to signin
        context.router.replace(const SignUpPageRoute());
      } else if (state is AuthStateTryLogin) {
        //navigate to login
        context.router.replace(LoginPageRoute(user: state.userModel));
      }
    }, builder: (context, state) {
      print('Im Builder SplashScreen');
      print(state);

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
