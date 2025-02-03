// ignore_for_file: unused_local_variable

import 'dart:developer';

// import 'dart:io';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/core/session/model/app_event.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/amity_core_client.dart';
import 'package:dio/dio.dart';

/// Http API Client
class HttpApiClient {
  /// init [HttpApiClient]
  HttpApiClient({
    required AmityCoreClientOption amityCoreClientOption,
  }) {
    final baseOptions = BaseOptions(
      baseUrl: amityCoreClientOption.httpEndpoint.endpoint,
      connectTimeout: Duration(milliseconds: 30 * 1000),
      sendTimeout: Duration(milliseconds: 10 * 60 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
      contentType: 'application/json',
      responseType: ResponseType.json,
    );

    dio = Dio(baseOptions);
    dio.transformer = BackgroundTransformer();

    dio.interceptors.add(QueuedInterceptorsWrapper(onRequest: (options, handler) {
      if (serviceLocator.isRegistered<AccountHiveEntity>()) {
        options.headers['authorization'] = 'Bearer ${serviceLocator<AccountHiveEntity>().accessToken}';
        // options.headers['cookie'] = 'userId=${AmityCoreClient.getUserId()}';
      }
      handler.next(options);
    }, onError: (e, handler) {
      if (e.response != null && e.response!.statusCode == 401) {
        log('>>>>> Token Expire');
        final userId = AmityCoreClient.getUserId();
        final refreshToken = serviceLocator<SessionResponse>().refreshToken;

        /// Unregister the [SessionResponse] to remove all previous session detail
        serviceLocator.unregister<SessionResponse>();

        ///get the session request params
        final params = serviceLocator<AuthenticationRequest>();

        serviceLocator<AuthenticationRepo>().login(params, isLegacyVersion: CoreClient.isLegacyLogin()).then((value) {
          var options = e.response!.requestOptions;
          dio.fetch(options).then((value) {
            handler.resolve(value);
          });
        }).onError((error, stackTrace) {
          CoreClient.onAppEvent(AppEvent.TokenExpire);
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