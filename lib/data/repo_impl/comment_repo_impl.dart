import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/domain.dart';

class CommentRepoImpl extends CommentRepo {
  final CommentDbAdapter commentDbAdapter;

  CommentRepoImpl({required this.commentDbAdapter});
  @override
  Future<AmityComment> getCommentByIdFromDb(String commentId) async {
    final commentHiveEntity =
        await commentDbAdapter.getCommentEntity(commentId);
    return commentHiveEntity.convertToAmityComment();
  }
}
