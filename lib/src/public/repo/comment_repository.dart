import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/public/query_builder/comment/comment_creator_builder.dart';
import 'package:amity_sdk/src/public/query_builder/comment/comment_get_query_builder.dart';

class CommentRepository {
  AmityCommentCreateTargetSelector createComment() {
    return AmityCommentCreateTargetSelector(useCase: serviceLocator());
  }

  AmityCommentQueryTypeSelector getComments() {
    return AmityCommentQueryTypeSelector(useCase: serviceLocator());
  }
}
