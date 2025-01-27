import 'package:flutter/material.dart';
import 'package:password_safe/presentation/passwords/globals.dart' as globals;

class AccountCount extends StatefulWidget {
  const AccountCount({super.key});

  @override
  State<AccountCount> createState() => _AccountCountState();
}

class _AccountCountState extends State<AccountCount> {
  @override
  Widget build(BuildContext context) {
    globals.filterTag.addListener(() {
      if (mounted) setState(() {});
    });

    globals.searchQuery.addListener(() {
      if (mounted) setState(() {});
    });

    return Container(
      alignment: globals.filterTag.value != 0
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: globals.filterTag.value != 0
          ? Text(
              'Filter aktiv: ${globals.showPasswordLength}/${globals.passwordLength} angezeigt',
              style: TextStyle(fontSize: 15),
            )
          : globals.searchQuery.value != ''
              ? Text(
                  'Suche aktiv: ${globals.showPasswordLength}/${globals.passwordLength}',
                  style: TextStyle(fontSize: 15),
                )
              : SizedBox(height: 18),
    );
  }
}
