import 'package:amity_sdk/core/model/api_request/update_comment_request.dart';
import 'package:amity_sdk/lib.dart';

abstract class CommentRepo {
  Future<AmityComment> getCommentByIdFromDb(String commentId);

  Future<AmityComment> createComment(CreateCommentRequest request);
  Future<List<AmityComment>> queryComment(GetCommentRequest request);
  Future<Tuple2<List<AmityComment>, String>> queryCommentPagingData(
      GetCommentRequest request);

  Future<AmityComment> getComment(String commentId);
  Future<AmityComment> updateComment(
      String commentId, UpdateCommentRequest request);
  Future<bool> deleteComment(String commentId);

  Future<bool> flagComment(String commentId);
  Future<bool> unflagComment(String commentId);
  Future<bool> isCommentFlagByMe(String commentId);
}
