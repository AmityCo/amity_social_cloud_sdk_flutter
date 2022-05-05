import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter_repo.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityFeedRepoImpl extends CommunityFeedRepo {
  final CommunityFeedApiInterface communiytFeedApiInterface;

  final DbAdapterRepo dbAdapterRepo;
  final PostRepo postRepo;

  CommunityFeedRepoImpl({
    required this.communiytFeedApiInterface,
    required this.dbAdapterRepo,
    required this.postRepo,
  });

  @override
  Future<Tuple2<List<AmityPost>, String>> getCommunityFeed(
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

    return Tuple2(amitPosts, data.paging!.next ?? '');
  }
}
