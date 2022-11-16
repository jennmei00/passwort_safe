import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:password_safe/presentation/passwords/widgets/menu_account_line.dart';
import 'package:password_safe/presentation/passwords/widgets/password_detail_add/password_add.dart';
import 'package:password_safe/presentation/passwords/widgets/password_list.dart';
import 'package:password_safe/presentation/passwords/widgets/filter_search_line.dart';
import 'package:password_safe/theme.dart';

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
      child: Column(
        children: [
          SizedBox(height: 20),
          MenueAccountLine(),
          SizedBox(height: 20),
          FilterSearchLine(),
          SizedBox(height: 5),
          // Center(
          //   child: PasswordDetailAddContainer(),
          // )
          Expanded(
            child: PasswordList(),
          ),
        ],
      ),
    );
  }
}
