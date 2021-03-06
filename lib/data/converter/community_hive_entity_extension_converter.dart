import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/domain.dart';

extension CommunityHiveEntityExtension on CommunityHiveEntity {
  AmityCommunity convertToAmityCommunity() {
    return AmityCommunity()
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
      ..postsCount = postCount
      ..membersCount = membersCount
      ..isJoined = isJoined
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..updatedAt = editedAt;
  }
}
