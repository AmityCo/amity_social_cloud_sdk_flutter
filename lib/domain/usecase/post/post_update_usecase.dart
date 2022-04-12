import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/update_post_request.dart';
import 'package:amity_sdk/domain/domain.dart';

class PostUpdateUsecase extends UseCase<AmityPost, UpdatePostRequest> {
  final PostRepo postRepo;
  final PostComposerUsecase postComposerUsecase;
  PostUpdateUsecase(
      {required this.postRepo, required this.postComposerUsecase});

  @override
  Future<AmityPost> get(UpdatePostRequest params) async {
    final amityPost = await postRepo.updatePostById(params);
    final amityComposedPost = await postComposerUsecase.get(amityPost);
    return amityComposedPost;
  }

  @override
  Stream<AmityPost> listen(UpdatePostRequest params) {
    throw UnimplementedError();
  }
}
