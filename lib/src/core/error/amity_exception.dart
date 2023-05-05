class AmityException implements Exception {
  final String message;
  final int code;
  final dynamic data;
  AmityException({required this.message, required this.code, this.data});

  @override
  String toString() {
    return message;
  }
}
