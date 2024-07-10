class HttpExcept implements Exception {
  HttpExcept({
    this.title,
    this.message,
    this.statusCode,
  });

  final String? title;

  final String? message;

  final int? statusCode;
}
