import 'package:amity_sdk/core/usercase/usecase.dart';
import 'package:amity_sdk/domain/domain.dart';

class GetPostByIdUseCase extends UseCase<AmityPost, String> {
  final PostRepo postRepo;
  final PostComposerUsecase postComposerUsecase;
  GetPostByIdUseCase(
      {required this.postRepo, required this.postComposerUsecase});

  @override
  Future<AmityPost> get(String params) async {
    //1. Get the public model (AmityPost) from data layer
    //2. Use the composer usecase to compose the public model (fill the detail)

    final amityPost = await postRepo.getPostById(params);
    final amityComposedPost = await postComposerUsecase.get(amityPost);
    return amityComposedPost;
  }

  @override
  Stream<AmityPost> listen(String params) {
    throw UnimplementedError();
  }
}
