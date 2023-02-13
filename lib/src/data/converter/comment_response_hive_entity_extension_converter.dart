import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/model.dart';

/// CommentHiveEntityExtension
extension CommentHiveEntityExtension on CommentHiveEntity {
  /// Convert [CommentHiveEntity] to [AmityComment]
  AmityComment convertToAmityComment() {
    AmityCommentReferenceType amityCommentReferenceType =
        AmityCommentReferenceTypeExtension.enumOf(referenceType!);

    //Data type
    AmityDataType amityCommentType = AmityDataTypeExtension.enumOf(dataType!);
    AmityCommentData? amityCommentData;
    switch (amityCommentType) {
      case AmityDataType.TEXT:
        amityCommentData =
            CommentTextData(commentId: commentId, text: data!.text);
        break;
      case AmityDataType.IMAGE:
        amityCommentData =
            CommentImageData(commentId: commentId, fileId: data!.fileId);
        break;
      case AmityDataType.VIDEO:
        amityCommentData = CommentVideoData(
          commentId: commentId,
          fileId: data!.thumbnailFileId,
          rawData: data?.videoFileId,
        );
        break;
      case AmityDataType.FILE:
        amityCommentData =
            CommentFileData(commentId: commentId, fileId: data!.fileId);
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
    List<AmityMentionee>? mentionees;

    if (this.mentionees != null) {
      for (Mentionee mentionee in this.mentionees!) {
        if (mentionee.type == 'user') {
          mentionees =
              mentionee.userIds!.map((e) => AmityMentionee(userId: e)).toList();
        }
      }
    }

    return AmityComment(commentId: commentId)
      ..referenceType = amityCommentReferenceType
      ..referenceId = referenceId
      ..userId = userId
      ..parentId = parentId
      ..dataType = amityCommentType
      ..data = amityCommentData
      ..childrenNumber = childrenNumber
      ..repliesId = children
      ..flagCount = flagCount
      ..reactions = AmityReactionMap(reactions: reactions)
      ..myReactions = myReactions
      ..hashFlag = hashFlag
      ..reactionCount = reactionsCount
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..editedAt = editedAt
      ..updatedAt = updatedAt
      ..path = path
      ..metadata = metadata
      ..flaggedByMe = flaggedByMe
      ..mentionees = mentionees;
  }
}
