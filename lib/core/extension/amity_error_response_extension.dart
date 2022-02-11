import 'package:amity_sdk/core/error/amity_exception.dart';
import 'package:amity_sdk/data/response/response.dart';

extension AmityErrorResponseExtension on AmityErrorResponse {
  AmityException amityException() {
    final exception = AmityException(
        message: data.detail == null ? message : data.detail![0], code: code);
    return exception;
  }
}
