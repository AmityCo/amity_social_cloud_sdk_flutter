import 'package:amity_sdk/data/data.dart';

extension CommentResponseExtension on CommentResponse {
  CommentHiveEntity convertToCommentHiveEntity() {
    return CommentHiveEntity()
      ..commentId = commentId
      ..userId = userId
      ..parentId = parentId
      ..rootId = rootId
      ..referenceId = referenceId
      ..referenceType = referenceType
      ..dataType = dataType
      ..data = data.convertToPostDataHiveEntity()
      ..childrenNumber = childrenNumber
      ..flagCount = flagCount
      ..reactionsCount = reactionsCount
      ..myReactions = myReactions
      ..isDeleted = isDeleted
      ..editedAt = editedAt
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..children = children
      ..segmentNumber = segmentNumber
      ..required = required;
  }
}
