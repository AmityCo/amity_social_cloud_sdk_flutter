import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Comment Object Extension
extension AmityCommentExtension on AmityComment {
  /// Comment create query builder
  AmityCommentCreateTargetSelector comment() {
    return AmityCommentCreateTargetSelector(
      useCase: serviceLocator(),
    ).post(referenceId!).parentId(commentId!);
  }

  /// Comment react query builder
  AddReactionQueryBuilder react() {
    return AddReactionQueryBuilder(
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
        commentFlagUsecase: serviceLocator(),
        commentUnflagUsecase: serviceLocator(),
        commentId: commentId!);
  }

  /// Delete Comment
  Future delete({bool hardDelete = false}) {
    return serviceLocator<CommentDeleteUseCase>().get(commentId!);
  }

  /// Edit Comment Text
  AmityTextCommentEditorBuilder edit() {
    return AmityTextCommentEditorBuilder(
        useCase: serviceLocator(), targetId: commentId!);
  }
}
