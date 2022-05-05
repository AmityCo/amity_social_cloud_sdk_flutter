import 'package:amity_sdk/src/core/model/api_request/create_comment_request.dart';
import 'package:amity_sdk/src/core/model/api_request/get_comment_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_comment_request.dart';
import 'package:amity_sdk/src/data/response/create_comment_response.dart';

abstract class CommentApiInterface {
  Future<CreateCommentResponse> createComment(CreateCommentRequest request);
  Future<CreateCommentResponse> queryComment(GetCommentRequest request);

  Future<CreateCommentResponse> getComment(String commentId);
  Future<CreateCommentResponse> updateComment(
      String commentId, UpdateCommentRequest request);
  Future<bool> deleteComment(String commentId);

  Future<bool> flagComment(String commentId);
  Future<bool> unflagComment(String commentId);
  Future<bool> isCommentFlagByMe(String commentId);
}
