import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final Function deletePressed;
  final Icon icon;

  const DialogWidget(
      {super.key,
      required this.title,
      required this.content,
      required this.deletePressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Text(title)
        ],
      ),
      content: Text(content),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              context.router.pop();
            },
            child: const Text(
              'Abbrechen',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
            onPressed: () => deletePressed(),
            child: const Text(
              'Löschen',
              style: TextStyle(color: Colors.red),
            )),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
