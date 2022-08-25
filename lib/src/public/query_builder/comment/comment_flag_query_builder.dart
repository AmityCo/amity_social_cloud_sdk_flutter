import 'package:amity_sdk/src/domain/domain.dart';

/// Comment Repor Query Builder
class CommentFlagQueryBuilder {
  final CommentFlagUsecase _commentFlagUsecase;
  final CommentUnflagUsecase _commentUnflagUsecase;
  final String _commentId;

  /// Init [CommentFlagQueryBuilder]
  CommentFlagQueryBuilder(
      {required CommentFlagUsecase commentFlagUsecase,
      required CommentUnflagUsecase commentUnflagUsecase,
      required String commentId})
      : _commentFlagUsecase = commentFlagUsecase,
        _commentUnflagUsecase = commentUnflagUsecase,
        _commentId = commentId;

  /// Flag Comment
  Future<bool> flag() {
    return _commentFlagUsecase.get(_commentId);
  }

  /// Unflag Comment
  Future<bool> unflag() {
    return _commentUnflagUsecase.get(_commentId);
  }
}
