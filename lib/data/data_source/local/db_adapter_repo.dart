import 'package:amity_sdk/data/data_source/local/local.dart';

/// This class hold all the Db Adapter instance as Singleton class, so we dont have to pass all diffrent db adapter in the constructor
/// of the repo, we can just pass this. this will bit clean the code.
class DbAdapterRepo {
  final PostDbAdapter postDbAdapter;
  final CommentDbAdapter commentDbAdapter;
  final UserDbAdapter userDbAdapter;
  final FileDbAdapter fileDbAdapter;
  final FeedPagingDbAdapter feedDbAdapter;
  final CommunityDbAdapter communityDbAdapter;

  DbAdapterRepo(
      {required this.postDbAdapter,
      required this.commentDbAdapter,
      required this.userDbAdapter,
      required this.fileDbAdapter,
      required this.feedDbAdapter,
      required this.communityDbAdapter});
}
