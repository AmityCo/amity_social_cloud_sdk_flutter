import 'package:amity_sdk/core/model/api_request/create_comment_request.dart';
import 'package:amity_sdk/core/model/api_request/get_comment_request.dart';
import 'package:amity_sdk/data/response/response.dart';

abstract class CommentApiInterface {
  Future<CreatePostResponse> createComment(CreateCommentRequest request);
  Future<CreatePostResponse> queryComment(GetCommentRequest request);
  Future<bool> deleteComment(String commentId);
}
