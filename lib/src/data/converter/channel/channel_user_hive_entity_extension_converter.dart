import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelUserHiveExtensionConverter]
extension ChannelUserHiveExtensionConverter on ChannelUserHiveEntity {
  ///
  AmityChannelMember convertToAmityChannelMember() {
    return AmityChannelMember()
      ..channelId = channelId
      ..membership = AmityMembershipTypeExtension.enumOf(membership!)
      ..userId = userId
      ..isMuted = isMuted
      ..isBanned = isBanned
      ..roles = AmityRoles(roles: roles)
      ..permissions = AmityPermissions(permissions: permissions);
  }
}
