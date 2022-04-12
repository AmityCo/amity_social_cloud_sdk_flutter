import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class PostGetUsecase
    extends UseCase<Tuple2<List<AmityPost>, String>, GetPostRequest> {
  final PostRepo postRepo;
  final PostComposerUsecase postComposerUsecase;
  PostGetUsecase({required this.postRepo, required this.postComposerUsecase});

  @override
  Future<Tuple2<List<AmityPost>, String>> get(GetPostRequest params) async {
    final amityPost = await postRepo.queryPost(params);
    final amityComposedPost = await Stream.fromIterable(amityPost.item1)
        .asyncMap((event) => postComposerUsecase.get(event))
        .toList();
    return amityPost.withItem1(amityComposedPost);
  }

  @override
  Stream<Tuple2<List<AmityPost>, String>> listen(GetPostRequest params) {
    throw UnimplementedError();
  }
}
