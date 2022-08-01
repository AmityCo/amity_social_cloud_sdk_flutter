import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Community Feed Repo Impl
class CommunityFeedRepoImpl extends CommunityFeedRepo {
  /// Community Feed API Interface
  final CommunityFeedApiInterface communiytFeedApiInterface;

  /// Common Db Adapter Repo
  final DbAdapterRepo dbAdapterRepo;

  /// Post Repo
  final PostRepo postRepo;

  /// Init Community Feed Repo Impl
  CommunityFeedRepoImpl({
    required this.communiytFeedApiInterface,
    required this.dbAdapterRepo,
    required this.postRepo,
  });

  @override
  Future<PageListData<List<AmityPost>, String>> getCommunityFeed(
      GetCommunityFeedRequest request) async {
    final data = await communiytFeedApiInterface.getCommunityFeed(request);

    //Save the feed sequence in to feed db
    final feedEntity = data.convertToFeedHiveEntity();
    await dbAdapterRepo.feedDbAdapter.updateFeedCollection(feedEntity);

    //Save post and nested data post/user/childpost/file/community/
    await data.saveToDb(dbAdapterRepo);

    //Get all the post from the post repo
    final amitPosts = await Stream.fromIterable(feedEntity.postIds!)
        .asyncMap((postId) => postRepo.getPostByIdFromDb(postId))
        .toList();

    return PageListData(amitPosts, data.paging!.next ?? '');
  }
}
