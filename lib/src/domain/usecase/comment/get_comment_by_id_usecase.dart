import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetCommentByIdUseCase extends UseCase<AmityComment, String> {
  final CommentRepo commentRepo;

  GetCommentByIdUseCase({required this.commentRepo});

  @override
  Future<AmityComment> get(String params) {
    return commentRepo.getCommentByIdFromDb(params);
  }
}
