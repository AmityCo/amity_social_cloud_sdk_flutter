import 'package:amity_sdk/src/core/error/amity_exception.dart';
import 'package:amity_sdk/src/data/data.dart';

extension AmityErrorResponseExtension on AmityErrorResponse {
  AmityException amityException() {
    final exception = AmityException(message: message, code: code);
    return exception;
  }
}
