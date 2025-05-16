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
  Future<BarcodeModel> getInfoBarcode({required String barcode}) async {
    try {
      final response = await _restClient.auth().get('/gtins/$barcode');
      final data = await response.data;
      final produto = BarcodeModel.fromMap(data);
      return produto;
    } on RestClientException catch (e, s) {
      if (e.statusCode == 413) {
        throw const Failure(
            message: 'Requisição excede o tamanho máximo permitido;');
      }
      _log.error('Erro ao buscar informações do código de barras', e, s);
      throw Failure(
          message:
              e.message ?? 'Erro ao buscar informações do código de barras');
    } catch (e, s) {
      _log.error('Erro ao converter resposta da API', e, s);
      throw const Failure(
          message: 'Erro ao buscar informações do código de barras');
    }
  }
}
