import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class AmityPostUpdateDataTypeSelector {
  late final PostUpdateUsecase _useCase;
  late final String _postId;
  late final String _userId;
  late final AmityPostTargetType _targetType;
  AmityPostUpdateDataTypeSelector(
      {required PostUpdateUsecase useCase,
      required String postId,
      required String userId,
      required AmityPostTargetType targetType})
      : _useCase = useCase,
        _postId = postId,
        _userId = userId,
        _targetType = targetType;

  AmityTextPostUpdatetor text(String text) {
    return AmityTextPostUpdatetor(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        text: text);
  }
}

class AmityTextPostUpdatetor {
  late PostUpdateUsecase _useCase;
  late String _targetId;
  late String _targetType;
  late String _text;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityTextPostUpdatetor(
      {required PostUpdateUsecase useCase,
      required String targetId,
      required String targetType,
      required String text}) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
    _text = text;
  }

  AmityTextPostUpdatetor text(String text) {
    _text = text;
    return this;
  }

  Future<AmityPost> apply() {
    CreatePostRequest request = CreatePostRequest(
        targetType: _targetType, targetId: _targetId, dataType: null);

    CreatePostData data = CreatePostData();
    data.text = _text;

    request.data = data;

    return _useCase.get(request);
  }
}
