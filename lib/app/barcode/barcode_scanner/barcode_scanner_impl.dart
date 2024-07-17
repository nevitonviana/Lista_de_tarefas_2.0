import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../core/exception/failure.dart';
import '../../core/logger/app_logger.dart';
import 'barcode_scanner.dart';

class BarcodeScannerImpl implements BarcodeScanner {
  final AppLogger _log;

  BarcodeScannerImpl({required AppLogger log}) : _log = log;

  @override
  Future<String> barcodeScanner() async {
    try {
      return await FlutterBarcodeScanner.scanBarcode('red', "Cancelar", false, ScanMode.BARCODE);
    } catch (e, s) {
      _log.error("Erro ao escaniar codigo", e, s);
      throw const Failure(message: "Erro ao Scanner codigo");
    }
  }
}
