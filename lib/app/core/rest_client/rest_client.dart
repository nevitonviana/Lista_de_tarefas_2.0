import 'rest_client_response.dart';

abstract class RestClient {
  RestClient auth();

  RestClient unauth();
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
