import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommentUpdateUsecase extends UseCase<AmityComment, UpdateCommentRequest> {
  final CommentRepo commentRepo;
  final CommentComposerUsecase postComposerUsecase;
  CommentUpdateUsecase(
      {required this.commentRepo, required this.postComposerUsecase});

  @override
  Future<AmityComment> get(UpdateCommentRequest params) async {
    final amityComment =
        await commentRepo.updateComment(params.commentId, params);
    final amityComposedComment = await postComposerUsecase.get(amityComment);
    return amityComposedComment;
  }

}
