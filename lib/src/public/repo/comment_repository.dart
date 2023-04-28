import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Comment Repository
class CommentRepository {
  /// Create Comment for the post and content
  AmityCommentCreationTarget createComment() {
    return AmityCommentCreationTarget(useCase: serviceLocator());
  }

  /// Get the comment for the post and content
  AmityCommentQueryTypeSelector getComments() {
    return AmityCommentQueryTypeSelector(useCase: serviceLocator());
  }

  /// Get [AmityReaction] for the comment Id
  GetReactionQueryBuilder getReaction({required String commentId}) {
    return GetReactionQueryBuilder.comment(commentId: commentId);
  }

  /// Get [AmityReaction] for the comment Id
  Future<AmityComment> getComment({required String commentId}) {
    return serviceLocator<CommentGetUseCase>().get(commentId);
  }
}
