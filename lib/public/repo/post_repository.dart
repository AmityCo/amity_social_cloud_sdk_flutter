import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/public/public.dart';

class PostRepository {
  PostByIdQueryBuilder getPost(String postId) {
    return PostByIdQueryBuilder(useCase: sl(), postId: postId);
  }

  // Stream<AmityPost> getPost(String postId) {
  //   return getPostByIdUseCase.callRepo(postId);
  // }
}
