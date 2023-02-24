import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/application/password/observer/observer_bloc.dart';
import 'package:password_safe/presentation/passwords/widgets/account_count_text.dart';
import 'package:password_safe/presentation/passwords/widgets/menu_account_line.dart';
import 'package:password_safe/presentation/passwords/widgets/password_list.dart';
import 'package:password_safe/presentation/passwords/widgets/filter_search_line.dart';

class PasswordOverViewBody extends StatelessWidget {
  const PasswordOverViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: BlocBuilder<ObserverBloc, ObserverState>(
        builder: (context, state) {
          if (state is ObserverInitial) {
            return Container();
          } else if (state is ObserverLodaing) {
            return Center(
              child: PlatformCircularProgressIndicator(
                cupertino: (context, platform) =>
                    CupertinoProgressIndicatorData(
                  color: themeData.colorScheme.secondary,
                ),
                material: (context, platform) => MaterialProgressIndicatorData(
                  color: themeData.colorScheme.secondary,
                ),
              ),
            );
          } else if (state is ObserverFailure) {
            return const Center(child: Text("Failure"));
          } else if (state is ObserverSuccess) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                children: [
                  SizedBox(height: 20),
                  MenueAccountLine(),
                  SizedBox(height: 20),
                  FilterSearchLine(),
                  SizedBox(height: 5),
                  AccountCount(),
                  Expanded(
                    child: PasswordList(passwordList: state.passwords),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
