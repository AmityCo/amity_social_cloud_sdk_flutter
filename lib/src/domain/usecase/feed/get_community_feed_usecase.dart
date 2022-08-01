import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetCommunityFeedUsecase extends UseCase<
    PageListData<List<AmityPost>, String>, GetCommunityFeedRequest> {
  final CommunityFeedRepo _communityFeedRepo;
  final PostComposerUsecase _postComposerUsecase;
  GetCommunityFeedUsecase(this._communityFeedRepo, this._postComposerUsecase);

  @override
  Future<PageListData<List<AmityPost>, String>> get(
      GetCommunityFeedRequest params) async {
    final amityPost = await _communityFeedRepo.getCommunityFeed(params);
    final amityComposedPost = await Stream.fromIterable(amityPost.data)
        .asyncMap((event) => _postComposerUsecase.get(event))
        .toList();
    return amityPost.withItem1(amityComposedPost);
  }

  @override
  Stream<PageListData<List<AmityPost>, String>> listen(
      GetCommunityFeedRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
