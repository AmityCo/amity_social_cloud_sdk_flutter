import 'package:amity_sdk/core/model/api_request/create_post_request.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';

abstract class PostRepo {
  Future<AmityPost> getPostById(String postId);
  Future<AmityPost> createPost(CreatePostRequest request);
  Future<AmityPost> getPostByIdFromDb(String id);
}
