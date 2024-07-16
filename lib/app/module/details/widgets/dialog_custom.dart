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
        content:  Text("Tem certeza que gostariade apagar, $label ?", style: const TextStyle(fontSize: 17),),
        actions: [
          TextButton.icon(
            onPressed: () async {
              onPressedDelete.call();
              Navigator.pop(context);
            },
            label: const Text("Deleta"),
            icon: const Icon(Icons.delete),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            label: const Text("Cancelar"),
            icon: const Icon(Icons.cancel_outlined),
          ),
        ],
      ),
    );
  }
}
