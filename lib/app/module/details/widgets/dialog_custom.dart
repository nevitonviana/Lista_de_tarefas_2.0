import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart' as mox;

class DialogCustom {
  final BuildContext _context;

  DialogCustom(BuildContext context) : _context = context;

  dialogDelete({required VoidCallback onPressedDelete}) {
    showDialog(
      context: _context,
      builder: (context) => AlertDialog(
        title: const Text("Deletar"),
        alignment: Alignment.center,
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
              mox.runInAction(
                () {},
              );
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
