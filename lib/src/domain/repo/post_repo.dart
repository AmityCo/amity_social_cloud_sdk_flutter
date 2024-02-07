import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/repo/amity_object_repository.dart';

abstract class PostRepo  extends AmityObjectRepository<PostHiveEntity, AmityPost>{
  //Future Method
  Future<PageListData<List<AmityPost>, String>> queryPost(
      GetPostRequest request);
  Stream<List<AmityPost>> listenPosts(RequestBuilder<GetPostRequest> request);

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

  Future<bool> approvePost(String postId);
  Future<bool> declinePost(String postId);

  /// Has Local Post
  bool hasLocalPost(String postId);
}
