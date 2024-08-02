import 'package:dio/dio.dart';

Map<String, String> get headers => {'accept': 'application/json', 'content-type': 'application/json'};

BaseOptions baseOptions(baseUrl) => BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
    );
