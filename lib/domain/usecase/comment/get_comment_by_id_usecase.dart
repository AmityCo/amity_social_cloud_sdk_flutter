import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class GetCommentByIdUseCase extends UseCase<AmityComment, String> {
  final CommentRepo commentRepo;

  GetCommentByIdUseCase({required this.commentRepo});

  @override
  Future<AmityComment> get(String params) {
    return commentRepo.getCommentByIdFromDb(params);
  }

  @override
  Stream<AmityComment> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
