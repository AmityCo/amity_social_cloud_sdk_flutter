// ignore_for_file: constant_identifier_names
enum AmityFeedType {
  PUBLISHED,
  REVIEWING,
  DECLINED,
}

extension AmityFeedTypeExtension on AmityFeedType {
  String get value {
    return [
      'published',
      'reviewing',
      'declined',
    ][index];
  }
}
