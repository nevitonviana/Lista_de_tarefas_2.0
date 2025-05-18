class RestClientResponse<T> {
  final T? data;
  final int? statusCode;
  final String? statusMessage;

  const RestClientResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
  });

  @override
  String toString() {
    return 'RestClientResponse(statusCode: $statusCode, statusMessage: $statusMessage, data: $data)';
  }
}
