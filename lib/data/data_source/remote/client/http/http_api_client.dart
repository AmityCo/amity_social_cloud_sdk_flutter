import 'dart:developer';
import 'dart:io';

import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
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
        if (serviceLocator.isRegistered<SessionResponse>()) {
          options.headers[HttpHeaders.authorizationHeader] =
              'Bearer ${serviceLocator<SessionResponse>().accessToken}';
        }
        return handler.next(options);
      },
    ));
    if (amityCoreClientOption.showLogs) {
      dio.interceptors.add(LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (logs) {
            log(logs as String);
          }));
    }
  }

  late Dio dio;

  Dio call() => dio;
}
