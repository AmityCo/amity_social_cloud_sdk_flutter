import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Usecase to get the comment details by comment ID
class CommentGetUseCase extends UseCase<AmityComment, String> {
  final CommentRepo commentRepo;
  final CommentComposerUsecase commentComposerUsecase;
  CommentGetUseCase(
      {required this.commentRepo, required this.commentComposerUsecase});
  @override
  Future<AmityComment> get(String params) async {
    final data = await commentRepo.getComment(params);

    //Composer usecase to fill in the details
    final composedComment = await commentComposerUsecase.get(data);

    return composedComment;
  }
}
