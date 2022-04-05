import 'package:amity_sdk/core/model/api_request/update_post_request.dart';
import 'package:amity_sdk/domain/domain.dart';

class AmityTextPostUpdator {
  late PostUpdateUsecase _useCase;
  late String _targetId;
  AmityTextPostUpdator({
    required PostUpdateUsecase useCase,
    required String targetId,
  }) {
    _useCase = useCase;
    _targetId = targetId;
  }

  AmityPostUpdater text(String text) {
    return AmityPostUpdater.textUpate(_useCase, _targetId, text);
  }
}

class AmityPostUpdater {
  final PostUpdateUsecase _usecase;
  final String _targetId;
  String? _text;

  factory AmityPostUpdater.textUpate(usecase, targetId, text) =>
      AmityPostUpdater(usecase,targetId).._text = text;

  AmityPostUpdater(this._usecase, this._targetId);

  Future update() {

    UpdatePostRequest updatePostRequest = UpdatePostRequest(postId: _targetId);

    UpdatePostData updateData = UpdatePostData();
    if (_text != null) updateData.text = _text;

    updatePostRequest.data = updateData;

    return _usecase.get(updatePostRequest);
  }
}
