import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Social Client
class AmitySocialClient {
  /// New Post Repo
  static PostRepository newPostRepository() => serviceLocator<PostRepository>();

  /// New Comment Repo
  static CommentRepository newCommentRepository() => serviceLocator<CommentRepository>();

  /// New Feed Repo
  static FeedRepository newFeedRepository() => serviceLocator<FeedRepository>();

  /// New Community Repo
  static AmityCommunityRepository newCommunityRepository() => serviceLocator<AmityCommunityRepository>();

  /// New Poll Repo
  static PollRepository newPollRepository() => serviceLocator<PollRepository>();

  /// New Poll Repo
  static AmityStoryRepository newStoryRepository() => serviceLocator<AmityStoryRepository>();
}
