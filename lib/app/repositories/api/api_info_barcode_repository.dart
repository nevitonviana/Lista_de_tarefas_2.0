import 'package:multiple_result/multiple_result.dart';

import '../../models/barcode_model.dart';

abstract class ApiInfoBarcodeRepository {
  Future<Result<BarcodeModel, Exception>> getInfoBarcodeBlueSoft(
      {required String barcode});

  Future<Result<BarcodeModel, Exception>> getInfoBarcodeOpenFoodFacts(
      {required String barcode});
}
