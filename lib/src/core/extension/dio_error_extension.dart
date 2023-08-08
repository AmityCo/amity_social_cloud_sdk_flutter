import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

/// dio error extention
extension DioErrorExtension on DioException {
  AmityException toAmityExcetion() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AmityException(message: 'Request Timeout', code: 408);
      case DioExceptionType.badResponse:
        return AmityErrorResponse.fromJson(response!.data).amityException();
      case DioExceptionType.cancel:
        return AmityException(message: 'Request Cancel', code: 499);
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        return AmityException(message: 'Unknow Error', code: 500);
    }
  }
}
