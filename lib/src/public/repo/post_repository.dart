import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

class PostRepository {
  Future<AmityPost> getPost(String postId) {
    return serviceLocator<GetPostByIdUseCase>().get(postId);
  }

  AmityPostGetTargetSelector getPosts() {
    return AmityPostGetTargetSelector(useCase: serviceLocator());
  }

  Stream<AmityPost> getPostStream(String postId) {
    return serviceLocator<GetPostByIdUseCase>().listen(postId);
  }

  AmityPostCreateTargetSelector createPost() {
    return AmityPostCreateTargetSelector(useCase: serviceLocator());
  }

  Future deletePost({required String postId, bool hardDelete = false}) {
    return serviceLocator<PostDeleteUseCase>().get(postId);
  }

  PostReviewQueryBuilder reviewPost({required String postId}) {
    return PostReviewQueryBuilder(
        postApproveUsecase: serviceLocator(),
        postDeclineUsecase: serviceLocator(),
        postId: postId);
  }
}
