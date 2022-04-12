import 'package:amity_sdk/amity.dart';
import 'package:amity_sdk/core/model/api_request/update_post_request.dart';

abstract class PostRepo {
  //Future Method
  Future<Tuple2<List<AmityPost>, String>> queryPost(GetPostRequest request);
  Future<AmityPost> getPostById(String postId);
  Future<AmityPost> createPost(CreatePostRequest request);
  Future<AmityPost> getPostByIdFromDb(String id);

  Future<AmityPost> updatePostById(UpdatePostRequest request);
  Future<bool> deletePostById(String postId);

  Future<bool> flagPost(String postId);
  Future<bool> unflagPost(String postId);
  Future<bool> isPostFlagByMe(String postId);

  //Streams Method
  Stream<AmityPost> getPostByIdStream(String postId);
}
