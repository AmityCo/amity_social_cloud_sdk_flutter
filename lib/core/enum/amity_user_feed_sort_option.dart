// ignore_for_file: constant_identifier_names
enum AmityUserFeedSortOption { FIRST_CREATED, LAST_CREATED }

extension AmityUserFeedSortOptionExtension on AmityUserFeedSortOption {
  String get value {
    return [
      'firstCreated',
      'lastCreated',
    ][index];
  }
}
