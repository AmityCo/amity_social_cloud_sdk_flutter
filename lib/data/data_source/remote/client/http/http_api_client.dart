// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:io';

import 'package:amity_sdk/lib.dart';
import 'package:dio/dio.dart';

class HttpApiClient {
  HttpApiClient({
    required AmityCoreClientOption amityCoreClientOption,
  }) {
    final baseOptions = BaseOptions(
      baseUrl: amityCoreClientOption.httpEndpoint.value,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      contentType: 'application/json',
      responseType: ResponseType.json,
    );

    dio = Dio(baseOptions);

    dio.interceptors
        .add(QueuedInterceptorsWrapper(onRequest: (options, handler) {
      if (serviceLocator.isRegistered<SessionResponse>()) {
        options.headers[HttpHeaders.authorizationHeader] =
            'Bearer ${serviceLocator<SessionResponse>().accessToken}';
      }
      handler.next(options);
    }, onError: (e, handler) {
      if (e.response!.statusCode == 401) {
        log('>>>>> Token Expire');
        final userId = AmityCoreClient.getUserId();
        final refreshToken = serviceLocator<SessionResponse>().refreshToken;

        /// Unregister the [SessionResponse] to remove all previous session detail
        serviceLocator.unregister<SessionResponse>();

        ///get the session request params
        final params = serviceLocator<AuthenticationRequest>();

        serviceLocator<AuthenticationRepo>().login(params).then((value) {
          var options = e.response!.requestOptions;
          dio.fetch(options).then((value) {
            handler.resolve(value);
          });
        }).onError((error, stackTrace) {
          handler.next(e);
        });
        return;
      }
      handler.next(e);
    }));
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
