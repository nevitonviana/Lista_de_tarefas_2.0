import 'package:flutter/material.dart';

class CustomDismissible extends StatelessWidget {
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const CustomDismissible({super.key, required this.child, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: onDismissed,
      background: Container(
        color: Colors.blue.shade200,
        alignment: Alignment.centerLeft,
        child: const Row(
          children: [
            Icon(
              Icons.edit_outlined,
              color: Colors.blueAccent,
              size: 40,
            ),
            SizedBox(width: 10),
            Text(
              "Editar",
              style: TextStyle(fontSize: 19),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        color: Colors.red.shade200,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Deleta",
              style: TextStyle(fontSize: 19),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.delete_forever,
              color: Colors.redAccent,
              size: 40,
            ),
          ],
        ),
      ),
      key: const Key("dismissible"),
      child: child,
    );
  }
}
