import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_delete_usecase.dart';
import 'package:amity_sdk/public/query_builder/comment/comment_create_query_builder.dart';
import 'package:amity_sdk/public/query_builder/comment/comment_flag_query_builder.dart';
import 'package:amity_sdk/public/query_builder/comment/comment_update_query_builder.dart';
import 'package:amity_sdk/public/query_builder/reaction/reaction_query_builder.dart';

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
        referenceType: ReactionReferenceType.COMMENT.value,
        referenceId: commentId!);
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

  AmityTextCommentUpdator edit() {
    return AmityTextCommentUpdator(
        useCase: serviceLocator(), targetId: commentId!);
  }
}
