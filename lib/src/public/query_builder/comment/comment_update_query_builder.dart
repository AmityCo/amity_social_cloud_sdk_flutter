import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityTextCommentUpdator {
  late CommentUpdateUsecase _useCase;
  late String _targetId;
  AmityTextCommentUpdator({
    required CommentUpdateUsecase useCase,
    required String targetId,
  }) {
    _useCase = useCase;
    _targetId = targetId;
  }

  AmityCommentUpdater text(String text) {
    return AmityCommentUpdater.textUpate(_useCase, _targetId, text);
  }
}

class AmityCommentUpdater {
  final CommentUpdateUsecase _usecase;
  final String _targetId;
  String? _text;

  factory AmityCommentUpdater.textUpate(usecase, targetId, text) =>
      AmityCommentUpdater(usecase, targetId).._text = text;

  AmityCommentUpdater(this._usecase, this._targetId);

  Future update() {
    UpdateCommentRequest updateCommentRequest =
        UpdateCommentRequest(commentId: _targetId);

    UpdateCommentData updateData = UpdateCommentData();
    if (_text != null) updateData.text = _text;

    updateCommentRequest.data = updateData;

    return _usecase.get(updateCommentRequest);
  }
}
