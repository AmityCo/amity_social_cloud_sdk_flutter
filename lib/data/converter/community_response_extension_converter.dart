import 'package:amity_sdk/data/data.dart';

extension CommunityResponsseExtension on CommunityResponse {
  CommunityHiveEntity convertToCommunityHiveEntity() {
    return CommunityHiveEntity()
      ..communityId = communityId
      ..path = path
      ..channelId = channelId
      ..userId = userId
      ..displayName = displayName
      ..description = description
      ..avatarFileId = avatarFileId
      ..isOfficial = isOfficial
      ..isPublic = isPublic
      ..onlyAdminCanPost = onlyAdminCanPost
      ..postCount = postsCount
      ..membersCount = membersCount
      ..isJoined = isJoined
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..editedAt = updatedAt;
  }
}
