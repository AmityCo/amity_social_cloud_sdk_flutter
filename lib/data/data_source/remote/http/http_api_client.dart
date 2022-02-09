import 'dart:developer';

import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/public/amity_core_client.dart';
import 'package:dio/dio.dart';

class HttpApiClient {
  HttpApiClient({required AmityCoreClientOption amityCoreClientOption}) {
    final baseOptions = BaseOptions(
      baseUrl: amityCoreClientOption.httpEndpoint.value,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      contentType: 'application/json',
      responseType: ResponseType.json,
    );

    dio = Dio(baseOptions);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
    ));

    dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (logs) {
          log(logs as String);
        }));
  }

  late Dio dio;

  Dio call() => dio;
}
