import 'package:amity_sdk/src/core/core.dart';

/// Amity Channel Type
// ignore_for_file: constant_identifier_names, public_member_api_docs

/// [AmityChannelMembershipFilter]
enum AmityChannelMembershipFilter {
  ALL,
  MUTED,
  BANNED,
}

/// [AmityChannelTypeExtension]
extension AmityChannelMemberTypeExtension on AmityChannelMembershipFilter {
  String get value {
    return AmityChannelMembershipFilter.values[index].name.toLowerCase();
  }

  List<String> get memberships {
    switch (this) {
      case AmityChannelMembershipFilter.ALL:
        return [
          AmityMembershipType.MEMBER.value,
          AmityMembershipType.BANNED.value,
        ];
      case AmityChannelMembershipFilter.MUTED:
        return [
          AmityMembershipType.MEMBER.value,
          AmityMembershipType.BANNED.value
        ];
      case AmityChannelMembershipFilter.BANNED:
        return [AmityMembershipType.BANNED.value];
    }
  }

  bool get isMuted {
    switch (this) {
      case AmityChannelMembershipFilter.ALL:
        return false;
      case AmityChannelMembershipFilter.MUTED:
        return true;
      case AmityChannelMembershipFilter.BANNED:
        return false;
    }
  }

  //TODO - this method need to acceesable with AmityChannelType
  static AmityChannelMembershipFilter enumOf(String value) {
    return AmityChannelMembershipFilter.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AmityChannelMembershipFilter.ALL,
    );
  }
}
