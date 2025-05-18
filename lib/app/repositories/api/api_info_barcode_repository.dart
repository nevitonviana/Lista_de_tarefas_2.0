import '../../models/barcode_model.dart';

abstract class ApiInfoBarcodeRepository{
  Future<BarcodeModel?> getInfoBarcodeBlueSoft({required String barcode});
  Future<BarcodeModel?> getInfoBarcodeOpenFoodFacts({required String barcode});
}