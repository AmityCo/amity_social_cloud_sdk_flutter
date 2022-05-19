// ignore_for_file: constant_identifier_names

enum AmityMembershipSortOption { FIRST_CREATED, LAST_CREATED }

extension AmityMembershipSortOptionExtension on AmityMembershipSortOption {
  String get value {
    return [
      'ASC',
      'DESC',
    ][index];
  }
}
