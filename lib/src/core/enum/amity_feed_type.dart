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
