import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Comment Repository
class CommentRepository {
  /// Create Comment for the post and content
  AmityCommentCreateTargetSelector createComment() {
    return AmityCommentCreateTargetSelector(useCase: serviceLocator());
  }

  /// Get the comment for the post and content
  AmityCommentQueryTypeSelector getComments() {
    return AmityCommentQueryTypeSelector(useCase: serviceLocator());
  }

  /// Get [AmityReaction] for the comment Id
  GetReactionQueryBuilder getReaction({required String commentId}) {
    return GetReactionQueryBuilder.comment(commentId: commentId);
  }
}
