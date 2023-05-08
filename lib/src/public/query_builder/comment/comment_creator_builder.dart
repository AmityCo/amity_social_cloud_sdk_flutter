// ignore_for_file: unused_field

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class AmityCommentCreationTarget {
  late CommentCreateUseCase _useCase;
  late String _referenceType;
  late String _referenceId;
  String? _parentId;
  // late AmityCommentTargetType _amityCommentTargetType;
  AmityCommentCreationTarget({
    required CommentCreateUseCase useCase,
  }) {
    _useCase = useCase;
  }

  AmityCommentCreationTarget post(String referenceId) {
    _referenceId = referenceId;
    _referenceType = AmityCommentTargetType.POST.value;
    return this;
  }

  AmityCommentCreationTarget content(String referenceId) {
    _referenceId = referenceId;
    _referenceType = AmityCommentTargetType.CONTENT.value;
    return this;
  }

  AmityCommentCreationTarget parentId(String parentId) {
    _parentId = parentId;
    return this;
  }

  AmityCommentCreationType create() {
    return AmityCommentCreationType(
      useCase: _useCase,
      referenceType: _referenceType,
      referenceId: _referenceId,
      parentId: _parentId,
      // amityCommentTargetType: _amityCommentTargetType,
    );
  }
}

class AmityCommentCreationType {
  late CommentCreateUseCase _useCase;
  late String _referenceType;
  late String _referenceId;
  String? _parentId;
  AmityCommentCreationType({
    required CommentCreateUseCase useCase,
    required String referenceType,
    required String referenceId,
    String? parentId,
  }) {
    _useCase = useCase;
    _referenceType = referenceType;
    _referenceId = referenceId;
    _parentId = parentId;
  }

  AmityTextCommentCreator text(String text) {
    return AmityTextCommentCreator(
      useCase: _useCase,
      referenceType: _referenceType,
      referenceId: _referenceId,
      parentId: _parentId,
      text: text,
    );
  }

  /// Data Type Image
  AmityAttachmentCommentCreator attachments(List<CommentImageAttachment> images) {
    return AmityAttachmentCommentCreator(
        useCase: _useCase,
        referenceType: _referenceType,
        referenceId: _referenceId,
        parentId: _parentId,
        images: images);
  }
}

class AmityTextCommentCreator extends CommentCreator {
  AmityTextCommentCreator(
      {required CommentCreateUseCase useCase,
      required String referenceType,
      required String referenceId,
      String? parentId,
      required String text})
      : super(useCase: useCase, referenceType: referenceType, referenceId: referenceId, parentId: parentId, text: text);
}

class AmityAttachmentCommentCreator extends CommentCreator {
  late final List<CommentImageAttachment> _images;

  AmityAttachmentCommentCreator(
      {required CommentCreateUseCase useCase,
      required String referenceType,
      required String referenceId,
      String? parentId,
      required List<CommentImageAttachment> images})
      : super(useCase: useCase, referenceType: referenceType, referenceId: referenceId, parentId: parentId) {
    _images = images;
  }

  CommentCreator text(String text) {
    _text = text;
    return this;
  }

  @override
  void _attachRequest(CreateCommentRequest request) {
    request.attachments =
        _images.map((e) => CommentAttachmentRequest(fileId: e.getFileId(), type: AmityDataType.IMAGE.value)).toList();
  }
}

abstract class CommentCreator {
  late CommentCreateUseCase _useCase;
  late String _referenceType;
  late String _referenceId;
  String? _parentId;
  String? _text;

  CommentCreator({
    required CommentCreateUseCase useCase,
    required String referenceType,
    required String referenceId,
    String? parentId,
    String? text,
  }) {
    _useCase = useCase;
    _referenceType = referenceType;
    _referenceId = referenceId;
    _parentId = parentId;
    _text = text;
  }

  List<AmityMentioneeTarget>? _mentionees;
  CommentCreator mentionUsers(List<String> userIds) {
    _mentionees ??= [];
    _mentionees!.add(AmityMentioneeTarget(type: AmityMentionType.USER.value, userIds: userIds));
    return this;
  }

  Map<String, dynamic>? _metadata;
  CommentCreator metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  void _attachRequest(CreateCommentRequest request) {}

  Future<AmityComment> send() {
    CreateCommentRequest request = CreateCommentRequest(referenceType: _referenceType, referenceId: _referenceId);

    //Attach attachment in the request
    _attachRequest(request);

    if (_text != null && _text!.isNotEmpty) {
      CreateCommentData data = CreateCommentData();
      data.text = _text;
      request.data = data;
    }

    if (_parentId != null) {
      request.parentId = _parentId;
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
