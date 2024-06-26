abstract class Repository {
  Repository({required this.httpService});

  final HttpService httpService;
}

abstract class HttpService {
  Future<BaseResponse> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
  });

  Future<BaseResponse> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  });

  Future<BaseResponse> patch(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  });

  Future<BaseResponse> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  });
}

class BaseResponse {
  final Map<String, dynamic> data;
  final String message;

  factory BaseResponse.fromJson(Map<String, Object?> json) => BaseResponse(data: json['data'] as Map<String, dynamic>, message: json['message'].toString());

  BaseResponse({required this.data, required this.message});
}

String get MESSAGE_SUCCESS => 'success';
String get MESSAGE_UNSUCCESS => 'unsuccess';
