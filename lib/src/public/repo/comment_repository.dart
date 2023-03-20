import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Comment Repository
class CommentRepository {
  /* begin_public_function 
  id: comment.create
  api_style: async
  */
  /// Create Comment for the post and content
  AmityCommentCreateTargetSelector createComment() {
    return AmityCommentCreateTargetSelector(useCase: serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: comment.query
  api_style: async
  */
  /// Get the comment for the post and content
  AmityCommentQueryTypeSelector getComments() {
    return AmityCommentQueryTypeSelector(useCase: serviceLocator());
  }
  /* end_public_function */

  /* begin_public_function 
  id: poll.close
  */
  /// Get [AmityReaction] for the comment Id
  GetReactionQueryBuilder getReaction({required String commentId}) {
    return GetReactionQueryBuilder.comment(commentId: commentId);
  }
  /* end_public_function */

  /* begin_public_function 
  id: comment.get_by_ids
  */
  /// Get [AmityReaction] for the comment Id
  Future<AmityComment> getComment({required String commentId}) {
    return serviceLocator<CommentGetUseCase>().get(commentId);
  }
  /* end_public_function */
}
