import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

class AmitySocialClient {
  static PostRepository newPostRepository() => serviceLocator<PostRepository>();
  static CommentRepository newCommentRepository() =>
      serviceLocator<CommentRepository>();
  static FeedRepository newFeedRepository() => serviceLocator<FeedRepository>();

  static CommunityRepository newCommunityRepository() =>
      serviceLocator<CommunityRepository>();
}
