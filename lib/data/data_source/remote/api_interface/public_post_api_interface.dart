import 'package:amity_sdk/core/model/api_request/create_post_request.dart';
import 'package:amity_sdk/core/model/api_request/get_post_request.dart';
import 'package:amity_sdk/data/data.dart';

abstract class PublicPostApiInterface {
  Future<CreatePostResponse> queryPost(GetPostRequest request);
  Future<CreatePostResponse> createPost(CreatePostRequest request);

  Future<CreatePostResponse> getPostById(String postId);
  Future<CreatePostResponse> updatePostById(
      String postId, CreatePostRequest request);
  Future<bool> deletePostById(String postId);

  Future<bool> flagPost(String postId);
  Future<bool> unflagPost(String postId);
  Future<bool> isPostFlagByMe(String postId);
}
