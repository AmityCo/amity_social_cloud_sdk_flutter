import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/comment_hive_entity_6.dart';
import 'package:amity_sdk/domain/model/model.dart';

extension CommentHiveEntityExtension on CommentHiveEntity {
  AmityComment convertToAmityComment() {
    AmityCommentReferenceType amityCommentReferenceType =
        AmityCommentReferenceTypeExtension.enumOf(dataType!);

    AmityDataType amityDataType = AmityDataTypeExtension.enumOf(dataType!);
    AmityPostData? amityPostData;
    switch (amityDataType) {
      case AmityDataType.TEXT:
        amityPostData = TextData(postId: commentId, text: data!.text!);
        break;
      case AmityDataType.IMAGE:
        // TODO: Handle this case.
        break;
      case AmityDataType.VIDEO:
        // TODO: Handle this case.
        break;
      case AmityDataType.FILE:
        // TODO: Handle this case.
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
    return AmityComment()
      ..commentId = commentId
      ..referenceType = amityCommentReferenceType
      ..referenceId = referenceId
      ..userId = userId
      ..parentId = parentId
      ..dataType = amityDataType
      ..data = amityPostData
      ..childrenNumber = childrenNumber
      ..repliesId = children
      ..flagCount = flagCount
      ..myReactions = myReactions
      ..reactionCount = reactionsCount
      ..isDeleted = isDeleted
      ..createdAt = createdAt
      ..editedAt = editedAt
      ..updatedAt = updatedAt
      ..path = path;
  }
}
