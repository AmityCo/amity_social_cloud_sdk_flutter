import 'package:amity_sdk/core/enum/amity_comment_target_type.dart';
import 'package:amity_sdk/core/model/api_request/create_comment_request.dart';
import 'package:amity_sdk/domain/model/amity_comment.dart';
import 'package:amity_sdk/domain/model/amity_mentionee_target.dart';
import 'package:amity_sdk/domain/usecase/comment/comment_create_usecase.dart';

class AmityCommentCreateTargetSelector {
  late CommentCreateUseCase _useCase;
  late String _referenceType;
  late String _referenceId;
  String? _parentId;
  // late AmityCommentTargetType _amityCommentTargetType;
  AmityCommentCreateTargetSelector({
    required CommentCreateUseCase useCase,
  }) {
    _useCase = useCase;
  }

  AmityCommentCreateTargetSelector post(String referenceId) {
    _referenceId = referenceId;
    _referenceType = AmityCommentTargetType.POST.value;
    return this;
  }

  AmityCommentCreateTargetSelector content(String referenceId) {
    _referenceId = referenceId;
    _referenceType = AmityCommentTargetType.CONTENT.value;
    return this;
  }

  AmityCommentCreateTargetSelector parentId(String parentId) {
    _parentId = parentId;
    return this;
  }

  AmityCommentCreateDataTypeSelector create() {
    return AmityCommentCreateDataTypeSelector(
      useCase: _useCase,
      referenceType: _referenceType,
      referenceId: _referenceId,
      parentId: _parentId,
      // amityCommentTargetType: _amityCommentTargetType,
    );
  }
}

class AmityCommentCreateDataTypeSelector {
  late CommentCreateUseCase _useCase;
  late String _referenceType;
  late String _referenceId;
  String? _parentId;
  // late AmityCommentTargetType _amityCommentTargetType;
  AmityCommentCreateDataTypeSelector({
    required CommentCreateUseCase useCase,
    required String referenceType,
    required String referenceId,
    String? parentId,
    // required AmityCommentTargetType amityCommentTargetType
  }) {
    _useCase = useCase;
    _referenceType = referenceType;
    _referenceId = referenceId;
    _parentId = parentId;
    // _amityCommentTargetType = amityCommentTargetType;
  }

  AmityTextCommentCreator text(String text) {
    return AmityTextCommentCreator(
        useCase: _useCase,
        referenceType: _referenceType,
        referenceId: _referenceId,
        parentId: _parentId,
        // amityCommentTargetType: _amityCommentTargetType,
        text: text);
  }
}

class AmityTextCommentCreator {
  late CommentCreateUseCase _useCase;
  late String _referenceType;
  late String _referenceId;
  String? _parentId;
  // late AmityCommentTargetType _amityCommentTargetType;
  late String? _text;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityTextCommentCreator(
      {required CommentCreateUseCase useCase,
      required String referenceType,
      required String referenceId,
      String? parentId,
      // required AmityCommentTargetType amityCommentTargetType,
      String? text}) {
    _useCase = useCase;
    _referenceType = referenceType;
    _referenceId = referenceId;
    _parentId = parentId;
    // _amityCommentTargetType = amityCommentTargetType;
    _text = text;
  }

  Future<AmityComment> send() {
    CreateCommentRequest request = CreateCommentRequest(
        referenceType: _referenceType, referenceId: _referenceId);

    CreateCommentData data = CreateCommentData();
    if (_text != null) data.text = _text;

    request.data = data;

    if (_parentId != null) {
      request.parentId = _parentId;
      request.commentId = _parentId;
    }

    return _useCase.get(request);
  }
}
