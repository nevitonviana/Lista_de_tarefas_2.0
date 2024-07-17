import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class ShowBarcode {
  generator({required BuildContext context, required String barcode}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            BarcodeWidget(
              barcode: Barcode.code93(),
              data: barcode.padLeft(13, '0'),
              errorBuilder: (context, error) => Center(
                child: Text("Codigo de barra invalido $error"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
