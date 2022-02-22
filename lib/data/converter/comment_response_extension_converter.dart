import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/local/hive_entity/comment_hive_entity_6.dart';

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
