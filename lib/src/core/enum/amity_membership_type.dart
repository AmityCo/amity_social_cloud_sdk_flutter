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
