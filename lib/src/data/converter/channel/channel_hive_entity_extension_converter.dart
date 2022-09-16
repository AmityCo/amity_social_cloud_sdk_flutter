import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [ChannelHiveExtensionConverter]
extension ChannelHiveExtensionConverter on ChannelHiveEntity {
  ///
  AmityChannel convertToAmityChannel() {
    //Data type
    AmityChannelType amityChannelType = AmityChannelTypeExtension.enumOf(type!);

    return AmityChannel()
      ..channelId = channelId
      ..displayName = displayName
      ..metadata = metadata
      ..messageCount = messageCount
      ..isRateLimited = isRateLimited
      ..isMuted = isMuted
      ..lastActivity = lastActivity
      ..memberCount = memberCount
      ..tags = AmityTags(tags: tags)
      // ..unreadCount = unreadCount
      ..amityChannelType = amityChannelType
      ..avatarFileId = avatarFileId
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..updatedAt = updatedAt;
  }
}
