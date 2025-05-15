import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class ShowBarcode {
  void generator({required BuildContext context, required String barcode}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(16),
        title: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BarcodeWidget(
              barcode: Barcode.ean13(),
              data: barcode.padLeft(12, '0'),
              // EAN-13 precisa de 12 dígitos + checksum
              errorBuilder: (context, error) => Center(
                child: Text("Código de barras inválido:\n$error"),
              ),
              width: 200,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
