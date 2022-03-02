import 'package:amity_sdk/core/model/api_request/create_post_request.dart';
import 'package:amity_sdk/core/model/api_request/get_post_request.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';

abstract class PostRepo {
  //Future Method
  Future<List<AmityPost>> queryPost(GetPostRequest request);
  Future<AmityPost> getPostById(String postId);
  Future<AmityPost> createPost(CreatePostRequest request);
  Future<AmityPost> getPostByIdFromDb(String id);

  Future<AmityPost> updatePostById(String postId, CreatePostRequest request);
  Future<bool> deletePostById(String postId);

  Future<bool> flagPost(String postId);
  Future<bool> unflagPost(String postId);
  Future<bool> isPostFlagByMe(String postId);

  //Streams Method
  Stream<AmityPost> getPostByIdStream(String postId);
}
