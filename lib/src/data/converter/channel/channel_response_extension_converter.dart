import 'package:amity_sdk/src/data/data.dart';

/// [ChannelResponseExtensionConverter]
extension ChannelResponseExtensionConverter on ChannelResponse {
  /// Convert [ChannelResponse] to [ChannelHiveEntity]
  ChannelHiveEntity convertToChannelHiveEntity() {
    return ChannelHiveEntity()
      ..channelId = channelId
      ..isDistinct = isDistinct
      ..metadata = metadata
      ..type = type
      ..tags = tags
      ..isMuted = isMuted
      ..isRateLimited = isRateLimited
      ..muteTimeout = muteTimeout
      ..rateLimit = rateLimit
      ..rateLimitWindow = rateLimitWindow
      ..rateLimitTimeout = rateLimitTimeout
      ..displayName = displayName
      ..messageAutoDeleteEnabled = messageAutoDeleteEnabled
      ..autoDeleteMessageByFlagLimit = autoDeleteMessageByFlagLimit
      ..memberCount = memberCount
      ..messageCount = messageCount
      ..lastActivity = lastActivity
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..avatarFileId = avatarFileId
      ..isDeleted = isDeleted;
  }
}
