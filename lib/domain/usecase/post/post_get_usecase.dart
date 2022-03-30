import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class PostGetUsecase extends UseCase<AmityPost, GetPostRequest> {
  final PostRepo postRepo;
  final PostComposerUsecase postComposerUsecase;
  PostGetUsecase({required this.postRepo, required this.postComposerUsecase});

  @override
  Future<AmityPost> get(GetPostRequest params) async {
    throw UnimplementedError();
    // final amityPost = await postRepo.createPost(params);
    // final amityComposedPost = await postComposerUsecase.get(amityPost);
    // return amityComposedPost;
  }

  @override
  Stream<AmityPost> listen(GetPostRequest params) {
    throw UnimplementedError();
  }
}
