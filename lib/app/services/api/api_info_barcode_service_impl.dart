import '../../core/exception/failure.dart';
import '../../core/logger/app_logger.dart';
import '../../core/rest_client/rest_client_exception.dart';
import '../../models/barcode_model.dart';
import '../../repositories/api/api_info_barcode_repository.dart';
import 'api_info_barcode_service.dart';

class ApiInfoBarcodeServiceImpl implements ApiInfoBarcodeService {
  final ApiInfoBarcodeRepository _repositoryApi;
  final AppLogger _log;

  ApiInfoBarcodeServiceImpl(
      {required ApiInfoBarcodeRepository repositoryApi, required AppLogger log})
      : _repositoryApi = repositoryApi,
        _log = log;

  @override
  Future<BarcodeModel?> getInfoBarcode({required String barcode}) async {
    try {
      final openFoodResp = await _repositoryApi.getInfoBarcodeOpenFoodFacts(barcode: barcode);

      return openFoodResp.when(
        (success) => success,
        (error) async {
          final blueSoftResp = await _repositoryApi.getInfoBarcodeBlueSoft(barcode: barcode);
          return blueSoftResp.when(
            (success) => success,
            (error) => throw Failure(
              message: error.toString(),
            ),
          );
        },
      );
    } on RestClientException catch (e, s) {
      _log.error('Erro ao buscar informações do código de barras', e, s);
      throw Failure(message: e.response.toString());
    }
  }
}
