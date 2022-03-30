import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/public/public.dart';

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
}
