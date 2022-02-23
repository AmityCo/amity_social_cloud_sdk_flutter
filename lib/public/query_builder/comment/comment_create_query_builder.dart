import 'package:amity_sdk/core/enum/amity_comment_target_type.dart';
import 'package:amity_sdk/domain/model/amity_Comment.dart';
import 'package:amity_sdk/domain/model/amity_mentionee_target.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_create_usecase.dart';
import 'package:amity_sdk/public/amity_core_client.dart';

class AmityCommentCreateTargetSelector {
  late CommentCreateUseCase _useCase;
  AmityCommentCreateTargetSelector({required CommentCreateUseCase useCase}) {
    _useCase = useCase;
  }

  AmityCommentCreateDataTypeSelector create() {
    return AmityCommentCreateDataTypeSelector(
        useCase: _useCase,
        userId: AmityCoreClient.getUserId(),
        targetType: AmityCommentTargetType.POST);
  }
}

class AmityCommentCreateDataTypeSelector {
  late CommentCreateUseCase _useCase;
  late String _userId;
  late AmityCommentTargetType _targetType;
  AmityCommentCreateDataTypeSelector(
      {required CommentCreateUseCase useCase,
      required String userId,
      required AmityCommentTargetType targetType}) {
    _useCase = useCase;
    _userId = userId;
    _targetType = targetType;
  }

  AmityTextCommentCreator text(String text) {
    return AmityTextCommentCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        text: text);
  }
}

class AmityTextCommentCreator {
  late CommentCreateUseCase _useCase;
  late String _targetId;
  late String _targetType;
  late String? _text;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityTextCommentCreator(
      {required CommentCreateUseCase useCase,
      required String targetId,
      required String targetType,
      String? text}) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
    _text = text;
  }

  Future<AmityComment> send() {
    //   CreateCommentRequest request = CreateCommentRequest(
    //       targetType: _targetType, targetId: _targetId, dataType: null);

    //   CreateCommentData data = CreateCommentData();
    //   if (_text != null) data.text = _text;

    //   request.data = data;

    //   return _useCase.get(request);
    throw UnimplementedError();
  }
}
