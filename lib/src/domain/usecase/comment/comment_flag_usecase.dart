import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommentFlagUsecase extends UseCase<bool, String> {
  final CommentRepo commentRepo;

  CommentFlagUsecase({required this.commentRepo});

  @override
  Future<bool> get(String params) {
    return commentRepo.flagComment(params);
  }

  @override
  Stream<bool> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
