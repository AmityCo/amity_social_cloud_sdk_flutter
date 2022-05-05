enum AmityUserFeedSortOption { FIRST_CREATED, LAST_CREATED }

extension AmityUserFeedSortOptionExtension on AmityUserFeedSortOption {
  String get value {
    return [
      'firstCreated',
      'lastCreated',
    ][index];
  }
}
