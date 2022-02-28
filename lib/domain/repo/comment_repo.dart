import 'package:amity_sdk/core/model/api_request/create_comment_request.dart';
import 'package:amity_sdk/core/model/api_request/get_comment_request.dart';
import 'package:amity_sdk/domain/model/model.dart';

abstract class CommentRepo {
  Future<AmityComment> getCommentByIdFromDb(String commentId);
  Future<AmityComment> createComment(CreateCommentRequest request);
  Future<List<AmityComment>> queryComment(GetCommentRequest request);
  Future<bool> deleteComment(String commentId);
}
