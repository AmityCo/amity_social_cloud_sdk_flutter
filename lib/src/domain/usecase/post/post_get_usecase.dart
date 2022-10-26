import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class PostGetUsecase
    extends UseCase<PageListData<List<AmityPost>, String>, GetPostRequest> {
  final PostRepo postRepo;
  final PostComposerUsecase postComposerUsecase;
  PostGetUsecase({required this.postRepo, required this.postComposerUsecase});

  @override
  Future<PageListData<List<AmityPost>, String>> get(
      GetPostRequest params) async {
    final amityPost = await postRepo.queryPost(params);
    final amityComposedPost = await Stream.fromIterable(amityPost.data)
        .asyncMap((event) => postComposerUsecase.get(event))
        .toList();
    return amityPost.withItem1(amityComposedPost);
  }
}
