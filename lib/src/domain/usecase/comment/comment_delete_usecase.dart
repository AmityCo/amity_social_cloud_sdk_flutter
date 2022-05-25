import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommentDeleteUseCase extends UseCase<void, String> {
  final CommentRepo commentRepo;

  CommentDeleteUseCase({required this.commentRepo});

  @override
  Future get(String params) {
    return commentRepo.deleteComment(params);
  }

  @override
  Stream<void> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
