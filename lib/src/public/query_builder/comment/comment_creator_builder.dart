// ignore_for_file: unused_field

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

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

  AmityTextCommentCreator mentionUsers(List<String> userIds) {
    _mentionees ??= [];
    _mentionees!.add(AmityMentioneeTarget(
        type: AmityMentionType.USER.value, userIds: userIds));
    return this;
  }

  /// Add metadata to Amity Post
  AmityTextCommentCreator metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  Future<AmityComment> send() {
    CreateCommentRequest request = CreateCommentRequest(
        referenceType: _referenceType, referenceId: _referenceId);

    CreateCommentData data = CreateCommentData();
    if (_text != null) data.text = _text;

    request.data = data;

    if (_parentId != null) {
      request.parentId = _parentId;
      // request.commentId = _parentId;
    }

    if (_mentionees != null) {
      request.mentionees = _mentionees;
    }

    if (_metadata != null) {
      request.metadata = _metadata;
    }

    return _useCase.get(request);
  }
}
