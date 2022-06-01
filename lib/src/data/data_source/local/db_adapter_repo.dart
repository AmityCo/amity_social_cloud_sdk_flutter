import 'package:amity_sdk/src/data/data_source/local/db_adapter/community_member_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/db_adapter.dart';

/// This class hold all the Db Adapter instance as Singleton class, so we dont have to pass all diffrent db adapter in the constructor
/// of the repo, we can just pass this. this will bit clean the code.
class DbAdapterRepo {
  final PostDbAdapter postDbAdapter;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final FeedPagingDbAdapter feedDbAdapter;
  final CommunityDbAdapter communityDbAdapter;
  final CommunityMemberDbAdapter communityMemberDbAdapter;
  final CommunityCategoryDbAdapter communityCategoryDbAdapter;

  DbAdapterRepo(
      {required this.postDbAdapter,
      required this.commentDbAdapter,
      required this.userDbAdapter,
      required this.fileDbAdapter,
      required this.feedDbAdapter,
      required this.communityDbAdapter,
      required this.communityMemberDbAdapter,
      required this.communityCategoryDbAdapter});
}
