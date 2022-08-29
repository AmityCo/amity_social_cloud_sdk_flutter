import 'package:amity_sdk/src/data/data_source/local/db_adapter/db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/message_db_adapter.dart';

/// This class hold all the Db Adapter instance as Singleton class, so we dont have to pass all diffrent db adapter in the constructor
/// of the repo, we can just pass this. this will bit clean the code.
class DbAdapterRepo {
  /// Post Db Adapter
  final PostDbAdapter postDbAdapter;

  /// Comment Db Adapter
  final CommentDbAdapter commentDbAdapter;

  /// User Db Adapter
  final UserDbAdapter userDbAdapter;

  /// File Db Adapter
  final FileDbAdapter fileDbAdapter;

  /// Feed Paging Db Adapter
  final FeedPagingDbAdapter feedDbAdapter;

  /// Community Db Adapter
  final CommunityDbAdapter communityDbAdapter;

  /// Community Memebr Db Adapter
  final CommunityMemberDbAdapter communityMemberDbAdapter;

  /// Community Category Db Adapter
  final CommunityCategoryDbAdapter communityCategoryDbAdapter;

  /// Poll Db Adapter
  final PollDbAdapter pollDbAdapter;

  /// Message Db Adapter
  final MessageDbAdapter messageDbAdapter;

  /// Init DbAdapter Repo
  DbAdapterRepo(
      {required this.postDbAdapter,
      required this.commentDbAdapter,
      required this.userDbAdapter,
      required this.fileDbAdapter,
      required this.feedDbAdapter,
      required this.communityDbAdapter,
      required this.communityMemberDbAdapter,
      required this.communityCategoryDbAdapter,
      required this.pollDbAdapter,
      required this.messageDbAdapter});
}
