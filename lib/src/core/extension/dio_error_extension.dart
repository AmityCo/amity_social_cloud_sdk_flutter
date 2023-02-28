import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

/// dio error extention
extension DioErrorExtension on DioError {
  AmityException toAmityExcetion() {
    switch (type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return AmityException(message: 'Request Timeout', code: 408);
      case DioErrorType.response:
        return AmityErrorResponse.fromJson(response!.data).amityException();
      case DioErrorType.cancel:
        return AmityException(message: 'Request Cancel', code: 499);
      case DioErrorType.other:
        return AmityException(message: 'Unknow Error', code: 500);
    }
  }
}
