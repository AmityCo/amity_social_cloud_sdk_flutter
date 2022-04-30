enum AmityFlagType { SPAM, HATE_SPEECH }

extension AmityFlagTypeExtension on AmityFlagType {
  String get value {
    return [
      'spam',
      'hate_speech',
    ][index];
  }
}
