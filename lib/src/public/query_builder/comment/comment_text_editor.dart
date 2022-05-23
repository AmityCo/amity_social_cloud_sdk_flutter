import 'package:amity_sdk/src/core/model/api_request/update_comment_request.dart';
import 'package:amity_sdk/src/domain/usecase/comment/comment_update_usecase.dart';

class AmityTextCommentEditor {
  late CommentUpdateUsecase _useCase;
  late String _targetId;
  late AmityCommentUpdater _commentUpdater;
  AmityTextCommentEditor({
    required CommentUpdateUsecase useCase,
    required String targetId,
  }) {
    _useCase = useCase;
    _targetId = targetId;
    _commentUpdater = AmityCommentUpdater.withTarget(_useCase, _targetId);
  }

  AmityTextCommentEditor text(String text) {
    _commentUpdater._text = text;
    return this;
  }

  AmityTextCommentEditor metadata(Map<String, dynamic> metadata) {
    _commentUpdater._metadata = metadata;
    return this;
  }

  Future update() {
    return _commentUpdater.update();
  }
}

class AmityCommentUpdater {
  final CommentUpdateUsecase _usecase;
  final String _targetId;
  String? _text;
  Map<String, dynamic>? _metadata;

  factory AmityCommentUpdater.withTarget(usecase, targetId) =>
      AmityCommentUpdater(usecase, targetId);

  AmityCommentUpdater(this._usecase, this._targetId);

  Future update() {
    UpdateCommentRequest updateCommentRequest =
        UpdateCommentRequest(commentId: _targetId);

    UpdateCommentData updateData = UpdateCommentData();
    if (_text != null) updateData.text = _text;

    updateCommentRequest.data = updateData;
    updateCommentRequest.metadata = _metadata;

    return _usecase.get(updateCommentRequest);
  }
}
