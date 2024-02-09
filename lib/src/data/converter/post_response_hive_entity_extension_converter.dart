import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Post Response Hive Entity Extension
extension PostResponseHiveEntityExtension on PostHiveEntity {
  /// Convert Hive Entity to Amity Post
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
    AmityFeedType feedType = AmityFeedTypeExtension.enumOf(this.feedType!);
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
      case AmityDataType.LIVESTREAM:
        amityPostData = LiveStreamData(
            postId: postId, streamId: data!.streamId, rawData: data!.toMap());
        break;
      case AmityDataType.POLL:
        amityPostData = PollData(
            postId: postId, pollId: data!.pollId!, rawData: data!.toMap());
        break;
      case AmityDataType.CUSTOM:
        // TODO: Handle this case.
        break;
    }

    List<AmityMentionee>? mentionees;

    if (this.mentionees != null) {
      for (Mentionee mentionee in this.mentionees!) {
        if (mentionee.type == 'user') {
          mentionees =
              mentionee.userIds!.map((e) => AmityMentionee(userId: e)).toList();
        }
      }
    }

    return AmityPost(postId: postId)
      ..targetType = amityPostTargetType
      ..mid = id
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
      ..hashFlag = hashFlag
      ..latestCommentIds = comments
      ..childrenPostIds = children
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..editedAt = editedAt
      ..updatedAt = updatedAt
      ..path = path
      ..feedType = feedType
      ..metadata = metadata
      ..flaggedByMe = flaggedByMe
      ..reach = reach
      ..impression = impression
      ..mentionees = mentionees;
  }

  bool isMatchingFilter(GetPostRequest request) {
    return isMatchingTargetType(request.targetType) &&
        isMatchingTargetid(request.targetId) &&
        isMatchingDataType(request.dataTypes) &&
        isMatchingFeedType(request.feedType) &&
        isMatchingDeleted(request.isDeleted);
  }

  bool isMatchingFeedType(String? feed) {
    if (feed == null) return true;
    return feedType == feed;
  }

  bool isMatchingDeleted( bool? isDeleted) {
    if (isDeleted == null) return true;
    return this.isDeleted == isDeleted;

  }

  bool isMatchingTargetType(String targetType) {
    return this.targetType == targetType;
  }

  bool isMatchingTargetid(String targetId) {
    return this.targetId == targetId;
  }


  bool isMatchingDataType(List<String>? dataTypes) {
    if (dataTypes == null) {
      return true;
    } else {
      for (String type in dataTypes) {
        if (dataType == AmityDataTypeExtension.enumOf(type).value) {
          return true;
        }
      }
      return false;
    }
  }

}
