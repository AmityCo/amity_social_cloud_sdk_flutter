import 'package:amity_sdk/src/core/model/api_request/update_comment_request.dart';
import 'package:amity_sdk/src/domain/usecase/comment/comment_update_usecase.dart';

class AmityTextCommentEditorBuilder {
  late CommentUpdateUsecase _useCase;
  late String _targetId;
  late AmityCommentUpdater updater;

  AmityTextCommentEditorBuilder({
    required CommentUpdateUsecase useCase,
    required String targetId,
  }) {
    _useCase = useCase;
    _targetId = targetId;
    updater = AmityCommentUpdater(_useCase, _targetId);
  }

  AmityTextCommentEditorBuilder text(String text) {
    updater._text = text;
    return this;
  }

  AmityTextCommentEditorBuilder metadata(Map<String, dynamic> metadata) {
    updater._metadata = metadata;
    return this;
  }

  AmityTextCommentEditor build() {
    return AmityTextCommentEditor(updater: updater);
  }
}

class AmityTextCommentEditor {
  late AmityCommentUpdater updater;

  AmityTextCommentEditor({required this.updater});

  Future update() {
    return updater.update();
  }
}

class AmityCommentUpdater {
  final CommentUpdateUsecase _usecase;
  final String _targetId;
  String? _text;
  Map<String, dynamic>? _metadata;

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
