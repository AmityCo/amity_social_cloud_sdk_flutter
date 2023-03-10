import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

abstract class CommentRepo {
  Future<AmityComment> getCommentByIdFromDb(String commentId);

  Future<AmityComment> createComment(CreateCommentRequest request);
  Future<List<AmityComment>> queryComment(GetCommentRequest request);
  Future<PageListData<List<AmityComment>, String>> queryCommentPagingData(
      GetCommentRequest request);

  Future<AmityComment> getComment(String commentId);
  Future<AmityComment> updateComment(
      String commentId, UpdateCommentRequest request);
  Future<bool> deleteComment(String commentId);

  Future<bool> flagComment(String commentId);
  Future<bool> unflagComment(String commentId);
  Future<bool> isCommentFlagByMe(String commentId);

  /// Has Local Comment
  bool hasLocalComment(String commentId);
}
