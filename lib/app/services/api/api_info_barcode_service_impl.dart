import '../../models/barcode_model.dart';
import '../../repositories/api/api_info_barcode_repository.dart';
import 'api_info_barcode_service.dart';

class ApiInfoBarcodeServiceImpl implements ApiInfoBarcodeService {
  final ApiInfoBarcodeRepository _repository;

  ApiInfoBarcodeServiceImpl({required ApiInfoBarcodeRepository repository})
      : _repository = repository;

  @override
  Future<BarcodeModel> getInfoBarcode({required String barcode}) =>
      _repository.getInfoBarcode(barcode: barcode);
}
