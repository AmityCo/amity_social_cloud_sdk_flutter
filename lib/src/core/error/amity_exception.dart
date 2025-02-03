import 'package:amity_sdk/src/core/enum/amity_error.dart';

class AmityException implements Exception {
  final String message;
  final int code;
  final dynamic data;
  AmityException({required this.message, required this.code, this.data});

  AmityError toAmityError() {
    return AmityErrorExtention.enumOf(code);
  }

  @override
  String toString() {
    return message;
  }
}
