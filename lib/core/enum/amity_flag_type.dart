// ignore_for_file: constant_identifier_names
enum AmityFlagType { SPAM, HATE_SPEECH }

extension AmityFlagTypeExtension on AmityFlagType {
  String get value {
    return [
      'spam',
      'hate_speech',
    ][index];
  }
}
