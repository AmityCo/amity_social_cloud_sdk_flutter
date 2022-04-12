import 'package:amity_sdk/core/error/amity_exception.dart';
import 'package:amity_sdk/data/data.dart';

extension AmityErrorResponseExtension on AmityErrorResponse {
  AmityException amityException() {
    final exception = AmityException(message: message, code: code);
    return exception;
  }
}
