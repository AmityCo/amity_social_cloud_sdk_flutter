import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/get_global_feed_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/repo/feed_repo.dart';

class GetGlobalFeedUsecase
    extends UseCase<Tuple2<List<AmityPost>, String>, GetGlobalFeedRequest> {
  final FeedRepo _feedRepo;
  final PostComposerUsecase _postComposerUsecase;
  GetGlobalFeedUsecase(this._feedRepo, this._postComposerUsecase);

  @override
  Future<Tuple2<List<AmityPost>, String>> get(
      GetGlobalFeedRequest params) async {
    final amityPost = await _feedRepo.getGlobalFeed(params);
    final amityComposedPost = await Stream.fromIterable(amityPost.item1)
        .asyncMap((event) => _postComposerUsecase.get(event))
        .toList();
    return amityPost.withItem1(amityComposedPost);
  }

  @override
  Stream<Tuple2<List<AmityPost>, String>> listen(GetGlobalFeedRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
