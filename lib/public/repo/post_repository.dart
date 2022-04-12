import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/usecase/post/post_delete_usecase.dart';
import 'package:amity_sdk/public/public.dart';

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
}
