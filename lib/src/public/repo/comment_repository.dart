import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/public/public.dart';

class CommentRepository {
  AmityCommentCreateTargetSelector createComment() {
    return AmityCommentCreateTargetSelector(useCase: serviceLocator());
  }

  AmityCommentQueryTypeSelector getComments() {
    return AmityCommentQueryTypeSelector(useCase: serviceLocator());
  }

  GetReactionQueryBuilder getReaction({required String commentId}) {
    return GetReactionQueryBuilder.comment(commentId: commentId);
  }
}
