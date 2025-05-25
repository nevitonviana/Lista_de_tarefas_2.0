import 'package:dio/dio.dart';

import '../../helpers/api_constants.dart';
import '../../logger/app_logger.dart';
import '../rest_client.dart';
import '../rest_client_exception.dart';
import '../rest_client_response.dart';

class DioRestClient implements RestClient {
  final AppLogger log;
  late final Dio _dio;
  late String _baseUrl;
  late Map<String, String> _headers;

  DioRestClient({required this.log, BaseOptions? baseOptions})
      : _dio = Dio(baseOptions ?? BaseOptions()) {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
      ),
    );
    // _dio.options.validateStatus = (status) => status! < 500;
  }

  @override
  RestClient auth() {
    _baseUrl = ApiConstants.baseUrlBlueSoft;
    _headers = {
      'X-Cosmos-Token': ApiConstants.apiToken,
      'Accept': 'application/json',
    };
    return this;
  }

  @override
  RestClient unauth() {
    _baseUrl = ApiConstants.baseUrlOpenFoodFacts;
    _headers = {};
    return this;
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl$path',
        queryParameters: queryParameters,
        options: Options(headers: {..._headers, ...?headers}),
      );
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }
}

Future<RestClientResponse<T>> _dioResponseConverter<T>(
    Response response) async {
  return RestClientResponse(
    data: response.data,
    statusCode: response.statusCode,
    statusMessage: response.statusMessage,
  );
}

Never _throwRestClientException(DioException e) {
  throw RestClientException(
    error: e.error,
    message: e.message,
    statusCode: e.response?.statusCode,
    response: RestClientResponse(
      data: e.response?.data,
      statusCode: e.response?.statusCode,
      statusMessage: e.response?.statusMessage,
    ),
  );
}
