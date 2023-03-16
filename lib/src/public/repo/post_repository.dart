import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Post Repo to get [AmityPost]
class PostRepository {
  /* begin_public_function 
  id: post.get
  */
  /// get composed [AmityPost] for the psot
  Future<AmityPost> getPost(String postId) {
    return serviceLocator<GetPostByIdUseCase>().get(postId);
  }
  /* end_public_function */

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
  /* end_public_function */

  /// Create Text/Image/Video/File post and retune [AmityPost]
  AmityPostCreateTargetSelector createPost() {
    return AmityPostCreateTargetSelector(useCase: serviceLocator());
  }

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
        postApproveUsecase: serviceLocator(),
        postDeclineUsecase: serviceLocator(),
        postId: postId);
  }

  /// Get [AmityReaction] for the post Id
  GetReactionQueryBuilder getReaction({required String postId}) {
    return GetReactionQueryBuilder.post(postId: postId);
  }
}
