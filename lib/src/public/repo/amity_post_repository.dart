import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_live_object_usecase.dart';
import 'package:amity_sdk/src/public/public.dart';
import 'package:amity_sdk/src/public/query_builder/post/post_get_live_object.dart';

/// Post Repo to get [AmityPost]
class PostRepository {

  PostGetLiveObject live = PostGetLiveObject();


  /* begin_public_function 
  id: post.get, poll.get, post.get_by_ids
  */
  /// get composed [AmityPost] for the psot
  @Deprecated("Use AmitySocialClient.newPostRepository().live.getPost(postId) instead")
  Future<AmityPost> getPost(String postId) {
    return serviceLocator<GetPostByIdUseCase>().get(postId);
  }
  /* end_public_function */


  // /* begin_public_function 
  // id: post.get, poll.get, post.get_by_ids
  // */
  // /// get composed [AmityPost] for the psot
  // Stream<AmityPost> getPostLiveObject(String postId) {
  //   return PostLiveObjectUseCase().execute(postId);
  // }
  // /* end_public_function */

  /* begin_public_function 
  id: post.query
  */
  /// Query [AmityPost] for the user with query builder
  AmityPostGetTargetSelector getPosts() {
    return AmityPostGetTargetSelector(useCase: serviceLocator());
  }
  /* end_public_function */

  /// listen to [AmityPost] with post id
  StreamController<AmityPost> getPostStream(String postId) {
    return serviceLocator<GetPostByIdUseCase>().listen(postId);
  }

  /* begin_public_function 
  id: post.create.text_post,post.create.image_post,post.create.video_post,post.create.file_post,post.create.poll_post,post.create.custom_post
  api_style: async
  */
  /// Create Text/Image/Video/File post and retune [AmityPost]
  AmityPostCreateTargetSelector createPost() {
    return AmityPostCreateTargetSelector(useCase: serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: post.soft_delete
  */
  /// delete the [AmityPost]
  Future deletePost({required String postId, bool hardDelete = false}) {
    return serviceLocator<PostDeleteUseCase>().get(postId);
  }
  /* end_public_function */

  /// Review the [AmityPost], Accept/denied
  PostReviewQueryBuilder reviewPost({required String postId}) {
    return PostReviewQueryBuilder(
        postApproveUsecase: serviceLocator(), postDeclineUsecase: serviceLocator(), postId: postId);
  }

  /// Get [AmityReaction] for the post Id
  GetReactionQueryBuilder getReaction({required String postId}) {
    return GetReactionQueryBuilder.post(postId: postId);
  }

  /* begin_public_function 
  id: post.check_flag_by_me
  */
  /// check if post is flagged by me
  Future<bool> isFlaggedByMe(String postId) {
    return serviceLocator<PostIsFlaggedByMeUsecase>().get(postId);
  }
  /* end_public_function */


}
