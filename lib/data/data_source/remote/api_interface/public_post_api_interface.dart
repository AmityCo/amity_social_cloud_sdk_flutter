import 'package:amity_sdk/core/model/api_request/create_post_request.dart';
import 'package:amity_sdk/data/data.dart';

abstract class PublicPostApiInterface {
  Future<CreatePostResponse> getPostById(String postId);
  Future<CreatePostResponse> createPost(CreatePostRequest request);
}
