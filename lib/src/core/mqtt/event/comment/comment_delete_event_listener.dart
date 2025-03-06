import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/local/db_adapter/story_db_adapter.dart';

/// [CommentDeleteEventListener]
class CommentDeleteEventListener extends CommentEventListener {
  @override
  String getEventName() {
    return 'comment.deleted';
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateCommentResponse.fromJson(json);

    /// Save the comment to the cache
    if (data.comments.isNotEmpty) {
      final comment = data.comments.first;


      switch (
          AmityCommentReferenceTypeExtension.enumOf(comment.referenceType)) {
        case AmityCommentReferenceType.POST:

          /// Get the post from the cache, update the comment count and save it again
          final post = serviceLocator<PostDbAdapter>()
              .getPostEntity(comment.referenceId);
          if (post != null) {
            post.commentsCount = (post.commentsCount ?? 0) - 1;
            serviceLocator<PostDbAdapter>().savePostEntity(post);
          }
          break;
        case AmityCommentReferenceType.CONTENT:
        // TODO: Handle this case.
        case AmityCommentReferenceType.STORY:
        /// Get the Story from the cache, update the comment count and save it again
          final story = serviceLocator<StoryDbAdapter>()
              .getStoryEntity(comment.referenceId);
          if (story != null) {
            story.commentsCount = (story.commentsCount ?? 0) - 1;
            serviceLocator<StoryDbAdapter>().saveStoryEntity(story);
          }
          break;
      }

      /// Save the comment to the local db
      data.saveToDb(serviceLocator());
    }
  }
}
