import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommentHasLocalUseCase extends SynchronousUseCase<bool, String> {
  final CommentRepo commentRepo;

  CommentHasLocalUseCase({required this.commentRepo});

  @override
  bool get(String params) {
    return commentRepo.hasLocalComment(params);
  }
}
