import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommentCreateUseCase extends UseCase<AmityComment, CreateCommentRequest> {
  final CommentRepo commentRepo;
  final CommentComposerUsecase commentComposerUsecase;
  CommentCreateUseCase(
      {required this.commentRepo, required this.commentComposerUsecase});
  @override
  Future<AmityComment> get(CreateCommentRequest params) async {
    final data = await commentRepo.createComment(params);

    //Composer usecase to fill in the details
    final composedComment = await commentComposerUsecase.get(data);

    return composedComment;
  }

  @override
  Stream<AmityComment> listen(CreateCommentRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
