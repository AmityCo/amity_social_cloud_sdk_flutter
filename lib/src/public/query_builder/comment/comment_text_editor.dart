import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityTextCommentEditorBuilder {
  late CommentUpdateUsecase _useCase;
  late String _targetId;
  late AmityCommentUpdater updater;
  List<AmityMentioneeTarget>? _mentionees;
  List<CommentImageAttachment>? _attachments;
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

  AmityTextCommentEditorBuilder mentionUsers(List<String> userIds) {
    _mentionees ??= [];
    _mentionees!.add(AmityMentioneeTarget(type: AmityMentionType.USER.value, userIds: userIds));
    updater._mentionees = _mentionees;
    return this;
  }

  // /// Data Type Image
  AmityTextCommentEditorBuilder attachments(List<CommentImageAttachment> images) {
    _attachments ??= [];
    _attachments!.addAll(images);
    updater._attachments = _attachments;
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
  List<AmityMentioneeTarget>? _mentionees;
  List<CommentImageAttachment>? _attachments;
  AmityCommentUpdater(this._usecase, this._targetId);

  Future update() {
    UpdateCommentRequest updateCommentRequest = UpdateCommentRequest(commentId: _targetId);

    UpdateCommentData updateData = UpdateCommentData();
    if (_text != null) updateData.text = _text;

    updateCommentRequest.data = updateData;
    if (_mentionees != null) {
      updateCommentRequest.mentionees = _mentionees;
    }

    if (_metadata != null) {
      updateCommentRequest.metadata = _metadata;
    }
    if (_attachments != null) {
      updateCommentRequest.attachments = _attachments!
          .map((e) => CommentAttachmentRequest(fileId: e.getFileId(), type: AmityDataType.IMAGE.value))
          .toList();
    }
    return _usecase.get(updateCommentRequest);
  }
}
