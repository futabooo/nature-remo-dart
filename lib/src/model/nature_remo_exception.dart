class NatureRemoException implements Exception {
  final int httpStatusCode;
  final String message;

  NatureRemoException({
    required this.httpStatusCode,
    required this.message,
  });

  @override
  String toString() => 'StatusCode: $httpStatusCode Error: $message';
}
