// ignore_for_file: constant_identifier_names

/// [AmityMembershipSortOption]
enum AmityMembershipSortOption { FIRST_CREATED, LAST_CREATED }

/// [AmityMembershipSortingOrderExtension]
extension AmityMembershipSortingOrderExtension on AmityMembershipSortOption {
  String get value {
    return [
      'firstCreated',
      'lastCreated',
    ][index];
  }
}
