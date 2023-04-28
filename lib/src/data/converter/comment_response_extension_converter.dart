import 'package:amity_sdk/src/data/data.dart';

/// Comment Response Extension
extension CommentResponseExtension on CommentResponse {
  /// Convert [CommentResponse] to [CommentHiveEntity]
  CommentHiveEntity convertToCommentHiveEntity() {
    return CommentHiveEntity()
      ..commentId = commentId
      ..path = path
      ..userId = userId
      ..parentId = parentId
      ..rootId = rootId
      ..referenceId = referenceId
      ..referenceType = referenceType
      ..dataType = dataType
      ..data = data.convertToPostDataHiveEntity()
      ..childrenNumber = childrenNumber
      ..flagCount = flagCount
      ..hashFlag = hashFlag?.toJson()
      ..reactions = reactions
      ..reactionsCount = reactionsCount
      ..myReactions = myReactions
      ..isDeleted = isDeleted
      ..editedAt = editedAt
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..children = children
      ..segmentNumber = segmentNumber
      ..metadata = metadata
      ..required = required
      ..mentionees = mentionees
      ..attachments = attanchment;
  }
}
