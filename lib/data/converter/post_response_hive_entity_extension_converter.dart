import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/post_hive_entity_5.dart';
import 'package:amity_sdk/domain/domain.dart';

extension PostResponseHiveEntityExtension on PostHiveEntity {
  AmityPost convertToAmityPost() {
    //Target type
    AmityPostTargetType amityPostTargetType =
        AmityPostTargetTypeExtension.enumOf(targetType!);
    AmityPostTarget? amityPostTarget;
    switch (amityPostTargetType) {
      case AmityPostTargetType.USER:
        amityPostTarget = UserTarget(targetUserId: targetId);
        break;
      case AmityPostTargetType.COMMUNITY:
        amityPostTarget = CommunityTarget(targetCommunityId: targetId);
        break;
    }

    //Data type
    AmityDataType amityDataType = AmityDataTypeExtension.enumOf(dataType!);
    AmityPostData? amityPostData;
    switch (amityDataType) {
      case AmityDataType.TEXT:
        amityPostData = TextData(postId: postId, text: data!.text);
        break;
      case AmityDataType.IMAGE:
        amityPostData = ImageData(postId: postId, fileId: data!.fileId);
        break;
      case AmityDataType.VIDEO:
        amityPostData = VideoData(
          postId: postId,
          fileId: data!.thumbnailFileId,
          rawData: data?.videoFileId,
        );
        break;
      case AmityDataType.FILE:
        amityPostData = FileData(postId: postId, fileId: data!.fileId);
        break;
      case AmityDataType.LIVE_STREAM:
        // TODO: Handle this case.
        break;
      case AmityDataType.POLL:
        // TODO: Handle this case.
        break;
      case AmityDataType.CUSTOM:
        // TODO: Handle this case.
        break;
    }
    return AmityPost(postId: postId)
      ..targetType = amityPostTargetType
      ..target = amityPostTarget
      ..parentPostId = parentPostId
      ..postedUserId = postedUserId
      ..sharedUserId = sharedUserId
      ..type = amityDataType
      ..data = amityPostData
      ..sharedCount = sharedCount
      ..reactions = AmityReactionMap(reactions: reactions)
      ..myReactions = myReactions
      ..reactionCount = reactionsCount
      ..commentCount = commentsCount
      ..flagCount = flagCount
      ..latestCommentIds = comments
      ..childrenPostIds = children
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..editedAt = editedAt
      ..updatedAt = updatedAt
      ..path = path;
  }
}
