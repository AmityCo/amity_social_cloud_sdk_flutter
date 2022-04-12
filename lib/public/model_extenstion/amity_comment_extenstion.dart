import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/public/query_builder/comment/comment_flag_query_builder.dart';
import 'package:amity_sdk/public/query_builder/reaction/reaction_query_builder.dart';

extension AmityCommentExtension on AmityComment {
  AddReactionQueryBuilder react() {
    return AddReactionQueryBuilder(
        addReactionUsecase: serviceLocator(),
        removeReactionUsecase: serviceLocator(),
        referenceType: ReactionReferenceType.COMMENT.value,
        referenceId: commentId!);
  }

  CommentFlagQueryBuilder report() {
    return CommentFlagQueryBuilder(
        commentFlagUsecase: serviceLocator(),
        commentUnflagUsecase: serviceLocator(),
        commentId: commentId!);
  }
}
