import 'package:amity_sdk/src/data/data.dart';

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
      ..postCount = postsCount ?? 0 //incase post count is null, keep it zero
      ..membersCount =
          membersCount ?? 0 // incase member count is null, keep it zero
      ..isJoined = isJoined
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..editedAt = updatedAt
      ..metadata = metadata
      ..categoryIds = categoryIds;
  }
}
