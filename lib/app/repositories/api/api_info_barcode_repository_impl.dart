import '../../core/exception/failure.dart';
import '../../core/logger/app_logger.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/rest_client/rest_client_exception.dart';
import '../../models/barcode_model.dart';
import 'api_info_barcode_repository.dart';

class ApiInfoBarcodeRepositoryImpl implements ApiInfoBarcodeRepository {
  final RestClient _restClient;
  final AppLogger _log;

  ApiInfoBarcodeRepositoryImpl(
      {required RestClient restClient, required AppLogger log})
      : _restClient = restClient,
        _log = log;

  @override
  Future<BarcodeModel?> getInfoBarcodeBlueSoft(
      {required String barcode}) async {
    try {
      final response = await _restClient.auth().get('/gtins/$barcode.json');
      final data = await response.data;
      switch (response.statusCode) {
        case 200:
          return BarcodeModel.fromMap(data);
        case 429:
          throw const Failure(
              message:
                  'Requisição excede a quantidade máxima de chamadas permitidas à API;');
        case 404:
          throw const Failure(
              message: 'Produto não encontrado na base de dados2;');
        case 413:
          throw const Failure(
              message: 'Requisição excede o tamanho máximo permitido;');
        default:
          throw const Failure(
              message: 'Erro ao buscar informações do código de barras');
      }
    } on RestClientException catch (e, s) {
      if (e.statusCode == 413) {
        throw const Failure(
            message: 'Requisição excede o tamanho máximo permitido;');
      }
      if (e.statusCode == 404) {
        throw const Failure(
            message: 'Produto não encontrado na base de dados1;');
      }
      _log.error('Erro ao buscar informações do código de barras', e, s);
      throw Failure(
          message:
              e.message ?? 'Erro ao buscar informações do código de barras');
    }
  }

  @override
  Future<BarcodeModel?> getInfoBarcodeOpenFoodFacts(
      {required String barcode}) async {
    try {
      final response = await _restClient.unauth().get('/product/$barcode.json');
      if (response.statusCode == 200 &&
          response.data['product']['_keywords'].isNotEmpty) {
        final product = await response.data['product'];
        return BarcodeModel.fromMap(product);
      }
      return null;
    } on RestClientException catch (e, s) {
      if (e.statusCode == 404) {
        throw const Failure(
            message: 'Produto nao encontrado na base de dados3;');
      }
      _log.error('Erro ao buscar informações do código de barras', e, s);
      throw Failure(
          message:
              e.message ?? 'Erro ao buscar informações do código de barras');
    }
  }
}
