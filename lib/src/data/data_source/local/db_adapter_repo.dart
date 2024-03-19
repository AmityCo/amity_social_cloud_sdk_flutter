import 'package:amity_sdk/src/data/data_source/local/db_adapter/analytics_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_target_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/tombstone_db_adapter.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/stream_db_adapter.dart';

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

  /// Community Feed Db Adapter
  final CommunityFeedDbAdapter communityFeedDbAdapter;

  /// Community Memebr Db Adapter
  final CommunityMemberDbAdapter communityMemberDbAdapter;

  /// Community Category Db Adapter
  final CommunityCategoryDbAdapter communityCategoryDbAdapter;

  /// Poll Db Adapter
  final PollDbAdapter pollDbAdapter;

  /// Message Db Adapter
  final MessageDbAdapter messageDbAdapter;

  /// Reaction Db Adapter
  final ReactionDbAdapter reactionDbAdapter;

  /// Channel Db Adapter
  final ChannelDbAdapter channelDbAdapter;

  /// Channel Member Db Adapter
  final ChannelUserDbAdapter channelUserDbAdapter;

  /// Tombstone Db Adapter
  final TombstoneDbAdapter tombstoneDbAdapter;

  /// Channel Member Db Adapter
  final StreamDbAdapter streamDbAdapter;

  /// Analytics Db Adapter
  final AnalyticsDbAdapter analyticsDbAdapter;

  /// Story Db Adapter
  final StoryDbAdapter storyDbAdapter;

  /// Story Target Db Adapter
  final StoryTargetDbAdapter storyTargetDbAdapter;

  /// Init DbAdapter Repo
  DbAdapterRepo({
    required this.postDbAdapter,
    required this.commentDbAdapter,
    required this.userDbAdapter,
    required this.fileDbAdapter,
    required this.feedDbAdapter,
    required this.communityDbAdapter,
    required this.communityFeedDbAdapter,
    required this.communityMemberDbAdapter,
    required this.communityCategoryDbAdapter,
    required this.pollDbAdapter,
    required this.messageDbAdapter,
    required this.reactionDbAdapter,
    required this.channelDbAdapter,
    required this.channelUserDbAdapter,
    required this.tombstoneDbAdapter,
    required this.streamDbAdapter,
    required this.analyticsDbAdapter,
    required this.storyDbAdapter,
    required this.storyTargetDbAdapter,
  });
}
