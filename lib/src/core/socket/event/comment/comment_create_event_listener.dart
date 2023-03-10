import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

/// [CommentCreateEventListener]
class CommentCreateEventListener extends CommentEventListener {
  @override
  String getEventName() {
    return 'comment.created';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateCommentResponse.fromJson(json);

    /// Save the comment to the cache
    if (data.comments.isNotEmpty) {
      final comment = data.comments.first;

      /// Get the post from the cache, update the comment count and save it again
      final post =
          serviceLocator<PostDbAdapter>().getPostEntity(comment.referenceId);
      if (post != null) {
        post.commentsCount = (post.commentsCount ?? 0) + 1;
        serviceLocator<PostDbAdapter>().savePostEntity(post);
      }

      /// Save the comment to the local db
      data.saveToDb(serviceLocator());
    }
  }
}
