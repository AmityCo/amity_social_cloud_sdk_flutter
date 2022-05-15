import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommentUnflagUsecase extends UseCase<bool, String> {
  final CommentRepo commentRepo;

  CommentUnflagUsecase({required this.commentRepo});

  @override
  Future<bool> get(String params) {
    return commentRepo.unflagComment(params);
  }

  @override
  Stream<bool> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
