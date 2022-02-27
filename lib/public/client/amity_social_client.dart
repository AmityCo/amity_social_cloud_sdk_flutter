import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/public/repo/comment_repository.dart';
import 'package:amity_sdk/public/repo/post_repository.dart';

class AmitySocialClient {
  static PostRepository newPostRepository() => serviceLocator<PostRepository>();
  static CommentRepository newCommentRepository() =>
      serviceLocator<CommentRepository>();
}
