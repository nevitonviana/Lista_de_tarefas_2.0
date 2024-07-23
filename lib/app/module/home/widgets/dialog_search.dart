import 'package:flutter/material.dart';

import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/ui/widgets/custom_text_form_field.dart';
import '../home_controller.dart';

class DialogCustom {
  final BuildContext _context;

  DialogCustom({required BuildContext context}) : _context = context;

  showSearch(
      {required TextEditingController controller,
      required VoidCallback onPressed,
      required VoidCallback onPressedIcon}) {
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
          suffixIcon: IconButton(onPressed: onPressedIcon, icon: const Icon(Icons.barcode_reader)),
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

  showSelectDueDate({
    required TextEditingController controller,
    required VoidCallback onPressed,
    required HomeController homeController,
  }) {
    showDialog(
      context: _context,
      builder: (context) => AlertDialog(
        title: const ListTile(
          title: Text(
            "Seleciona dia de evencimento",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            "selecionar os dias para avisa quantos dias falta para o  vencimento do produto exemple(5 dias para o vencimento ). sera mostrado de amarelo na seçao de rebaixa",
            style: TextStyle(fontSize: 13),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Dias selecionado ( ${homeController.daysSelectedForExpiration} )"),
            CustomTextFormField(controller: controller, label: "Dias"),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            label: const Text("Cancelar"),
            icon: const Icon(Icons.cancel_outlined),
          ),
          TextButton.icon(
            onPressed: () async {
              onPressed.call();
              Navigator.pop(context);
            },
            label: const Text("salvar"),
            icon: const Icon(Icons.save),
          )
        ],
      ),
    );
  }
}
