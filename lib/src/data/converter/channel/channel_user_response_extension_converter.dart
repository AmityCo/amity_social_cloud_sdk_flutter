import 'package:amity_sdk/src/data/data.dart';

/// [ChannelUserResponseExtensionConverter]
extension ChannelUserResponseExtensionConverter on ChannelUserResponse {
  /// Convert [ChannelUserResponse] to [ChannelUserHiveEntity]
  ChannelUserHiveEntity convertToChannelUserHiveEntity() {
    return ChannelUserHiveEntity()
      ..id = id
      ..channelId = channelId
      ..userId = userId
      ..membership = membership
      ..isBanned = isBanned
      ..lastActivity = lastActivity
      ..roles = roles
      ..permissions = permissions
      ..readToSegment = readToSegment
      ..lastMentionedSegment = lastMentionedSegment
      ..isMuted = isMuted
      ..muteTimeout = muteTimeout
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
  }
}
