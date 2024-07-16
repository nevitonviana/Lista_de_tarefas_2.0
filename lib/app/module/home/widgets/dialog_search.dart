import 'package:flutter/material.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class DialogSearch {
  final BuildContext _context;

  DialogSearch({required BuildContext context}) : _context = context;

  showSearch({required TextEditingController controller, required VoidCallback onPressed}) {
    showDialog(
      context: _context,
      // ignore: no_leading_underscores_for_local_identifiers
      builder: (_context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Produrar Itens "),
            IconButton(
                onPressed: () {
                  Navigator.of(_context).pop();
                },
                icon: const Icon(Icons.clear))
          ],
        ),
        content: CustomTextFormField(
          controller: controller,
          label: "Nome / Codigo",
          suffixIcon: Icons.barcode_reader,
        ),
        actions: [
          CustomButton(
            label: "Buscar",
            onPressed: () {
              Navigator.pop(_context);
              onPressed.call();
            },
          ),
        ],
      ),
    );
  }
}
