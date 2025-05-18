import '../../models/barcode_model.dart';

abstract class ApiInfoBarcodeService {
  Future<BarcodeModel?> getInfoBarcode({required String barcode});
}