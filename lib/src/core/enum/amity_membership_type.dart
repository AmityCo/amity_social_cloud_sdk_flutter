// ignore_for_file: constant_identifier_names, public_member_api_docs

/// [AmityMembershipType]
enum AmityMembershipType {
  MEMBER,
  BANNED,
  NONE,
}

/// [AmityMembershipTypeExtension]
extension AmityMembershipTypeExtension on AmityMembershipType {
  String get value {
    return [
      'member',
      'banned',
      'none',
    ][index];
  }

  static AmityMembershipType enumOf(String value) {
    return AmityMembershipType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityMembershipType.NONE,
    );
  }
}
