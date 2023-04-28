import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Comment Object Extension
extension AmityCommentExtension on AmityComment {
  /// Comment create query builder
  AmityCommentCreationTarget comment() {
    return AmityCommentCreationTarget(
      useCase: serviceLocator(),
    ).post(referenceId!).parentId(commentId!);
  }

  /// Comment react query builder
  AddReactionQueryBuilder react() {
    return AddReactionQueryBuilder<AmityComment>(
        addReactionUsecase: serviceLocator(),
        removeReactionUsecase: serviceLocator(),
        referenceType: AmityReactionReferenceType.COMMENT.value,
        referenceId: commentId!);
  }

  /// Get Reaction on Comment
  GetReactionQueryBuilder getReaction() {
    return GetReactionQueryBuilder.comment(commentId: commentId!);
  }

  /// Report Comment
  CommentFlagQueryBuilder report() {
    return CommentFlagQueryBuilder(
        commentFlagUsecase: serviceLocator(), commentUnflagUsecase: serviceLocator(), commentId: commentId!);
  }

  /* begin_public_function 
  id: comment.soft_delete
  api_style: async
  */
  /// Delete Comment
  Future delete({bool hardDelete = false}) {
    return serviceLocator<CommentDeleteUseCase>().get(commentId!);
  }
  /* end_public_function */

  /* begin_public_function 
  id: comment.update_comment
  api_style: async
  */
  /// Edit Comment Text
  AmityTextCommentEditorBuilder edit() {
    return AmityTextCommentEditorBuilder(useCase: serviceLocator(), targetId: commentId!);
  }
  /* end_public_function */

  /* begin_public_function 
  id: comment.check_flag_by_me
  api_style: async
  */
  /// check if post is flagged by me
  bool get isFlaggedByMe {
    if (hashFlag == null) return false;
    return (flaggedByMe ?? false) ||
        BloomFilter(hash: (hashFlag!['hash'] as String), m: hashFlag!['bits'] as int, k: hashFlag!['hashes'] as int)
            .mightContains(AmityCoreClient.getUserId());
  }
  /* end_public_function */

  /// Subscribe/Unsubscribe to comment events
  AmityTopicSubscription subscription(AmityCommentEvents events) {
    return AmityTopicSubscription(AmityTopic.COMMENT(this, events));
  }
}
