import 'package:amity_sdk/src/core/model/api_request/update_post_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityTextPostEditor {
  late PostUpdateUsecase _useCase;
  late String _targetId;
  late AmityPostUpdater _postUpdater;
  AmityTextPostEditor({
    required PostUpdateUsecase useCase,
    required String targetId,
  }) {
    _useCase = useCase;
    _targetId = targetId;
    _postUpdater = AmityPostUpdater.withTarget(_useCase, _targetId);
  }

  AmityTextPostEditor text(String text) {
    _postUpdater._text = text;
    return this;
  }

  AmityTextPostEditor metadata(Map<String, dynamic>? metadata) {
    _postUpdater._metadata = metadata;
    return this;
  }

  Future update() {
    return _postUpdater.update();
  }
}

class AmityPostUpdater {
  final PostUpdateUsecase _usecase;
  final String _targetId;
  String? _text;
  Map<String, dynamic>? _metadata;

  factory AmityPostUpdater.withTarget(usecase, targetId) =>
      AmityPostUpdater(usecase, targetId);

  AmityPostUpdater(this._usecase, this._targetId);

  Future update() {
    UpdatePostRequest updatePostRequest = UpdatePostRequest(postId: _targetId);

    UpdatePostData updateData = UpdatePostData();
    if (_text != null) updateData.text = _text;

    updatePostRequest.data = updateData;
    updatePostRequest.metadata = _metadata;

    return _usecase.get(updatePostRequest);
  }
}
