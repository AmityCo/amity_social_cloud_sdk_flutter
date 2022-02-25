import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/domain.dart';

extension PostResponseExtension on PostResponse {
  AmityPost convertToAmityPost() {
    return AmityPost();
  }

  PostHiveEntity convertToPostHiveEntity() {
    return PostHiveEntity()
      ..id = id
      ..path = path
      ..postId = postId
      ..parentPostId = parentPostId
      ..postedUserId = postedUserId
      ..sharedUserId = sharedUserId
      ..sharedCount = sharedCount
      ..targetId = targetId
      ..targetType = targetType
      ..dataType = dataType
      ..data = data.convertToPostDataHiveEntity()
      ..flagCount = flagCount
      // ..rections =reactions
      ..reactionsCount = reactionsCount
      ..myReactions = myReactions
      ..commentsCount = commentsCount
      ..comments = comments
      ..children = children
      ..isDeleted = isDeleted
      ..hasFlaggedComment = hasFlaggedComment
      ..hasFlaggedChildren = hasFlaggedChildren
      ..feedId = feedId
      ..require = require
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..editedAt = editedAt;
  }
}

// postResponse.convertToPostHiveEntity();
