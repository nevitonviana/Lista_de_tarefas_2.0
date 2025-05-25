import 'package:flutter/material.dart';

class DialogCustom {
  final BuildContext _context;

  DialogCustom(BuildContext context) : _context = context;

  dialogDelete({required VoidCallback onPressedDelete, required String label}) {
    showDialog(
      context: _context,
      builder: (context) => AlertDialog(
        title: const Text("Deleta"),
        alignment: Alignment.center,
        content: Text.rich(
          TextSpan(
              text: "Tem certeza que gostaria de apagar,",
              style: const TextStyle(
                fontSize: 17,
              ),
              children: [
                TextSpan(
                  text: '$label ?',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              onPressedDelete.call();
              Navigator.pop(context);
            },
            label: const Text(
              "Deleta",
              style: TextStyle(color: Colors.red),
            ),
            icon: const Icon(Icons.delete),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            label: const Text(
              "Cancelar",
              style: TextStyle(color: Colors.blue),
            ),
            icon: const Icon(Icons.cancel_outlined),
          ),
        ],
      ),
    );
  }
}
