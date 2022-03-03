import 'package:amity_sdk/domain/usecase/Comment/Comment_flag_usecase.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_unflag_usecase.dart';

class CommentFlagQueryBuilder {
  final CommentFlagUsecase _commentFlagUsecase;
  final CommentUnflagUsecase _commentUnflagUsecase;
  final String _commentId;
  CommentFlagQueryBuilder(
      {required CommentFlagUsecase commentFlagUsecase,
      required CommentUnflagUsecase commentUnflagUsecase,
      required String commentId})
      : _commentFlagUsecase = commentFlagUsecase,
        _commentUnflagUsecase = commentUnflagUsecase,
        _commentId = commentId;
  Future<bool> flag() {
    return _commentFlagUsecase.get(_commentId);
  }

  Future<bool> unflag() {
    return _commentUnflagUsecase.get(_commentId);
  }
}
