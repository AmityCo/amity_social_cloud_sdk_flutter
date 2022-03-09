import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

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
