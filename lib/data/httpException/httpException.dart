class HttpException {
  final String message;

  HttpException({required this.message});

  static HttpException fromJson(dynamic json) =>
      HttpException(message: json['message'] as String);
}
