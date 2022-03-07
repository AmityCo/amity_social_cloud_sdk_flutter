import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/public/query_builder/post/post_create_query_builder.dart';

class PostRepository {
  Future<AmityPost> getPost(String postId) {
    return serviceLocator<GetPostByIdUseCase>().get(postId);
  }

  Stream<AmityPost> getPostStream(String postId) {
    return serviceLocator<GetPostByIdUseCase>().listen(postId);
  }

  AmityPostCreateTargetSelector createPost() {
    return AmityPostCreateTargetSelector(useCase: serviceLocator());
  }

  // Stream<AmityPost> getPost(String postId) {
  //   return getPostByIdUseCase.callRepo(postId);
  // }
}
