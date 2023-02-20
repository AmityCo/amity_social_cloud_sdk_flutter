import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityTextPostEditorBuilder {
  late PostUpdateUsecase _useCase;
  late String _targetId;
  late AmityPostUpdater _updater;
  List<AmityMentioneeTarget>? _mentionees;

  AmityTextPostEditorBuilder({
    required PostUpdateUsecase useCase,
    required String targetId,
  }) {
    _useCase = useCase;
    _targetId = targetId;
    _updater = AmityPostUpdater(_useCase, _targetId);
  }

  AmityTextPostEditorBuilder text(String text) {
    _updater._text = text;
    return this;
  }

  AmityTextPostEditorBuilder metadata(Map<String, dynamic>? metadata) {
    _updater._metadata = metadata;
    return this;
  }

  AmityTextPostEditorBuilder mentionUsers(List<String> userIds) {
    _mentionees ??= [];
    _mentionees!.add(AmityMentioneeTarget(
        type: AmityMentionType.USER.value, userIds: userIds));
    _updater._mentionees = _mentionees;
    return this;
  }

  AmityTextPostEditor build() {
    return AmityTextPostEditor(updater: _updater);
  }
}

class AmityTextPostEditor {
  late AmityPostUpdater updater;

  AmityTextPostEditor({required this.updater});

  Future update() {
    return updater.update();
  }
}

class AmityPostUpdater {
  final PostUpdateUsecase _usecase;
  final String _targetId;
  String? _text;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityPostUpdater(this._usecase, this._targetId);

  Future update() {
    UpdatePostRequest updatePostRequest = UpdatePostRequest(postId: _targetId);

    UpdatePostData updateData = UpdatePostData();
    if (_text != null) updateData.text = _text;

    updatePostRequest.data = updateData;

    if (_mentionees != null) {
      updatePostRequest.mentionees = _mentionees;
    }

    if (_metadata != null) {
      updatePostRequest.metadata = _metadata;
    }

    return _usecase.get(updatePostRequest);
  }
}
