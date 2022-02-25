import 'package:amity_sdk/domain/model/model.dart';

abstract class CommentRepo {
  Future<AmityComment> getCommentByIdFromDb(String commentId);
}
