import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class PostUpdateUsecase extends UseCase<AmityPost, CreatePostRequest> {
  final PostRepo postRepo;
  final PostComposerUsecase postComposerUsecase;
  PostUpdateUsecase(
      {required this.postRepo, required this.postComposerUsecase});

  @override
  Future<AmityPost> get(CreatePostRequest params) async {
    final amityPost = await postRepo.updatePostById(params.postId!, params);
    final amityComposedPost = await postComposerUsecase.get(amityPost);
    return amityComposedPost;
  }

  @override
  Stream<AmityPost> listen(CreatePostRequest params) {
    throw UnimplementedError();
  }
}
