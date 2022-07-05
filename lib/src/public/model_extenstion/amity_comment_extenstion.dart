import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

extension AmityCommentExtension on AmityComment {
  AmityCommentCreateTargetSelector comment() {
    return AmityCommentCreateTargetSelector(
      useCase: serviceLocator(),
    ).post(referenceId!).parentId(commentId!);
  }

  AddReactionQueryBuilder react() {
    return AddReactionQueryBuilder(
        addReactionUsecase: serviceLocator(),
        removeReactionUsecase: serviceLocator(),
        referenceType: AmityReactionReferenceType.COMMENT.value,
        referenceId: commentId!);
  }

  GetReactionQueryBuilder getReaction() {
    return GetReactionQueryBuilder.comment(commentId: commentId!);
  }

  CommentFlagQueryBuilder report() {
    return CommentFlagQueryBuilder(
        commentFlagUsecase: serviceLocator(),
        commentUnflagUsecase: serviceLocator(),
        commentId: commentId!);
  }

  Future delete({bool hardDelete = false}) {
    return serviceLocator<CommentDeleteUseCase>().get(commentId!);
  }

  AmityTextCommentEditorBuilder edit() {
    return AmityTextCommentEditorBuilder(
        useCase: serviceLocator(), targetId: commentId!);
  }
}
