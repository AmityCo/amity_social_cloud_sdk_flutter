class AmityException implements Exception {
  final String message;
  final int code;

  AmityException({required this.message, required this.code});
}
