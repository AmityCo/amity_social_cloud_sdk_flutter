import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/repo/comment_repository.dart';
import 'package:amity_sdk/src/public/repo/feed_repository.dart';
import 'package:amity_sdk/src/public/repo/post_repository.dart';

class AmitySocialClient {
  static PostRepository newPostRepository() => serviceLocator<PostRepository>();
  static CommentRepository newCommentRepository() =>
      serviceLocator<CommentRepository>();
  static FeedRepository newFeedRepository() => serviceLocator<FeedRepository>();
}
