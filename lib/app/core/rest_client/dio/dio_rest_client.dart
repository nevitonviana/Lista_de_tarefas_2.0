import 'package:dio/dio.dart';

import '../../helpers/api_constants.dart';
import '../../logger/app_logger.dart';
import '../rest_client.dart';
import '../rest_client_exception.dart';
import '../rest_client_response.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;

  DioRestClient({required AppLogger log, BaseOptions? baseOptions}) {
    _dio = _createDio(baseOptions ?? _defaultOptions);
  }

  Dio _createDio(BaseOptions options) {
    final dio = Dio(options);
    dio.interceptors
        .add(LogInterceptor(requestBody: false, responseBody: false));
    return dio;
  }

  final _defaultOptions = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    headers: {
      'X-Cosmos-Token': ApiConstants.apiToken,
      'Accept': 'application/json',
    },
  );

  @override
  RestClient auth() => this;

  @override
  RestClient unauth() => this;

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: {..._defaultOptions.headers, ...?headers}),
      );
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
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
}
