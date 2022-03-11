import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/get_user_feed_request.dart';
import 'package:amity_sdk/core/utils/tuple.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/repo/user_feed_repo.dart';

class GetUserFeedUsecase
    extends UseCase<Tuple2<List<AmityPost>, String>, GetUserFeedRequest> {
  final UserFeedRepo _userFeedRepo;
  final PostComposerUsecase _postComposerUsecase;
  GetUserFeedUsecase(this._userFeedRepo, this._postComposerUsecase);

  @override
  Future<Tuple2<List<AmityPost>, String>> get(GetUserFeedRequest params) async {
    throw UnimplementedError();
    // final amityPost = await _feedRepo.getGlobalFeed(params);
    // final amityComposedPost = await Stream.fromIterable(amityPost.item1)
    //     .asyncMap((event) => _postComposerUsecase.get(event))
    //     .toList();
    // return amityPost.withItem1(amityComposedPost);
  }

  @override
  Stream<Tuple2<List<AmityPost>, String>> listen(GetUserFeedRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
