import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

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
