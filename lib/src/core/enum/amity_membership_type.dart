// ignore_for_file: constant_identifier_names

enum AmityMembershipType {
  MEMBER,
  BANNED,
  NONE,
}

extension AmityMembershipTypeExtension on AmityMembershipType {
  String get value {
    return [
      'member',
      'banned',
      'none',
    ][index];
  }
}
