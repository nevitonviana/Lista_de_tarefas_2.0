import '../../models/barcode_model.dart';

abstract class ApiInfoBarcodeRepository{
  Future<BarcodeModel> getInfoBarcode({required String barcode});
}