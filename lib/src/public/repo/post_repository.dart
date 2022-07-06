import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

class PostRepository {
  /// get composed [AmityPost] for the psot
  Future<AmityPost> getPost(String postId) {
    return serviceLocator<GetPostByIdUseCase>().get(postId);
  }

  /// Query [AmityPost] for the user with query builder
  AmityPostGetTargetSelector getPosts() {
    return AmityPostGetTargetSelector(useCase: serviceLocator());
  }

  /// listen to [AmityPost] with post id
  Stream<AmityPost> getPostStream(String postId) {
    return serviceLocator<GetPostByIdUseCase>().listen(postId);
  }

  /// Create Text/Image/Video/File post and retune [AmityPost]
  AmityPostCreateTargetSelector createPost() {
    return AmityPostCreateTargetSelector(useCase: serviceLocator());
  }

  /// delete the [AmityPost]
  Future deletePost({required String postId, bool hardDelete = false}) {
    return serviceLocator<PostDeleteUseCase>().get(postId);
  }

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
