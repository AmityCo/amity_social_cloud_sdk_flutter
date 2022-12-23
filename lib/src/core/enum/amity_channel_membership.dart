// ignore_for_file: constant_identifier_names

///AmityChannelMembership Enum
enum AmityChannelMembership { MEMBER, MUTED, BANNED }

/// [AmityChannelMembershipExtension]
extension AmityChannelMembershipExtension on AmityChannelMembership {
  String get value {
    return AmityChannelMembership.values[index].name.toLowerCase();
  }

  //TODO - this method need to acceesable with AmityChannelType
  static AmityChannelMembership enumOf(String value) {
    return AmityChannelMembership.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityChannelMembership.MEMBER,
    );
  }
}
