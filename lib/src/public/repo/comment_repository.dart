import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

class CommentRepository {
  AmityCommentCreateTargetSelector createComment() {
    return AmityCommentCreateTargetSelector(useCase: serviceLocator());
  }

  AmityCommentQueryTypeSelector getComments() {
    return AmityCommentQueryTypeSelector(useCase: serviceLocator());
  }
}
