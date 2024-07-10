// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:dio/dio.dart';

class LimitInterceptor extends Interceptor {
  LimitInterceptor({required this.dio});
  final Dio dio;

  @override
  Future<void> onError(DioException err, handler) async {
    if (err.response?.statusCode == 429) {
      return Future.delayed(Duration(milliseconds: Random().nextInt(200)), () async => handler.resolve(await dio.fetch(err.requestOptions)));
    }
    return handler.next(err);
  }
}
