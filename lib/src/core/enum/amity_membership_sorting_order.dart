// ignore_for_file: constant_identifier_names

enum AmityMembershipSortOption { FIRST_CREATED, LAST_CREATED }

extension AmityMembershipSortingOrderExtension on AmityMembershipSortOption {
  String get value {
    return [
      'firstCreated',
      'lastCreated',
    ][index];
  }
}
