import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostCreateUsecase extends UseCase<AmityPost, CreatePostRequest> {
  final PostRepo postRepo;
  final PostComposerUsecase postComposerUsecase;
  PostCreateUsecase(
      {required this.postRepo, required this.postComposerUsecase});

  @override
  Future<AmityPost> get(CreatePostRequest params) async {
    final amityPost = await postRepo.createPost(params);
    final amityComposedPost = await postComposerUsecase.get(amityPost);
    return amityComposedPost;
  }

  @override
  Stream<AmityPost> listen(CreatePostRequest params) {
    throw UnimplementedError();
  }
}
