import 'package:amity_sdk/core/service_locator/service_locator.dart';
import 'package:amity_sdk/public/query_builder/comment/comment_create_query_builder.dart';
import 'package:amity_sdk/public/query_builder/comment/comment_get_query_builder.dart';

class CommentRepository {
  AmityCommentCreateTargetSelector createComment() {
    return AmityCommentCreateTargetSelector(useCase: serviceLocator());
  }

  AmityCommentQueryTypeSelector getComments() {
    return AmityCommentQueryTypeSelector(useCase: serviceLocator());
  }
}
