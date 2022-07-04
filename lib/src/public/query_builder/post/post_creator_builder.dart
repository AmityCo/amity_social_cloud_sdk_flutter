// ignore_for_file: unused_field

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

class AmityPostCreateTargetSelector {
  late PostCreateUsecase _useCase;
  AmityPostCreateTargetSelector({required PostCreateUsecase useCase}) {
    _useCase = useCase;
  }

  AmityPostCreateDataTypeSelector targetMe() {
    return AmityPostCreateDataTypeSelector(
        useCase: _useCase,
        userId: AmityCoreClient.getUserId(),
        targetType: AmityPostTargetType.USER);
  }

  AmityPostCreateDataTypeSelector targetUser(String targetUser) {
    return AmityPostCreateDataTypeSelector(
        useCase: _useCase,
        userId: targetUser,
        targetType: AmityPostTargetType.USER);
  }

  AmityPostCreateDataTypeSelector targetCommunity(String communityId) {
    return AmityPostCreateDataTypeSelector(
        useCase: _useCase,
        userId: communityId,
        targetType: AmityPostTargetType.COMMUNITY);
  }
}

class AmityPostCreateDataTypeSelector {
  late PostCreateUsecase _useCase;
  late String _userId;
  late AmityPostTargetType _targetType;
  AmityPostCreateDataTypeSelector(
      {required PostCreateUsecase useCase,
      required String userId,
      required AmityPostTargetType targetType}) {
    _useCase = useCase;
    _userId = userId;
    _targetType = targetType;
  }

  AmityTextPostCreator text(String text) {
    return AmityTextPostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        text: text);
  }

  AmityImagePostCreator image(List<AmityImage> images) {
    return AmityImagePostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        images: images);
  }

  AmityVideoPostCreator video(List<AmityVideo> videos) {
    return AmityVideoPostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        videos: videos);
  }

  AmityFilePostCreator file(List<AmityFile> files) {
    return AmityFilePostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        files: files);
  }
}

class AmityTextPostCreator extends PostCreator {
  AmityTextPostCreator(
      {required PostCreateUsecase useCase,
      required String targetId,
      required String targetType,
      required String text})
      : super(useCase: useCase, targetId: targetId, targetType: targetType) {
    _text = text;
  }
}

class AmityImagePostCreator extends PostCreator {
  late final List<AmityImage> _images;

  AmityImagePostCreator(
      {required List<AmityImage> images,
      required PostCreateUsecase useCase,
      required String targetId,
      required String targetType})
      : super(useCase: useCase, targetId: targetId, targetType: targetType) {
    _images = images;
  }

  @override
  void _attachRequest(CreatePostRequest request) {
    request.attachments = _images
        .map((e) =>
            Attachment(fileId: e.fileId, type: AmityDataType.IMAGE.value))
        .toList();
  }
}

class AmityFilePostCreator extends PostCreator {
  late final List<AmityFile> _files;

  AmityFilePostCreator(
      {required List<AmityFile> files,
      required PostCreateUsecase useCase,
      required String targetId,
      required String targetType})
      : super(useCase: useCase, targetId: targetId, targetType: targetType) {
    _files = files;
  }

  @override
  void _attachRequest(CreatePostRequest request) {
    request.attachments = _files
        .map(
            (e) => Attachment(fileId: e.fileId, type: AmityDataType.FILE.value))
        .toList();
  }
}

class AmityVideoPostCreator extends PostCreator {
  late final List<AmityVideo> _videos;

  AmityVideoPostCreator(
      {required List<AmityVideo> videos,
      required PostCreateUsecase useCase,
      required String targetId,
      required String targetType})
      : super(useCase: useCase, targetId: targetId, targetType: targetType) {
    _videos = videos;
  }

  @override
  void _attachRequest(CreatePostRequest request) {
    request.attachments = _videos
        .map((e) =>
            Attachment(fileId: e.fileId, type: AmityDataType.VIDEO.value))
        .toList();
  }
}

abstract class PostCreator {
  late PostCreateUsecase _useCase;
  late String _targetId;
  late String _targetType;
  String? _text;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;

  PostCreator({
    required PostCreateUsecase useCase,
    required String targetId,
    required String targetType,
  }) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
  }

  PostCreator text(String text) {
    _text = text;
    return this;
  }

  PostCreator metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  void _attachRequest(CreatePostRequest request) {}

  Future<AmityPost> post() {
    CreatePostRequest request = CreatePostRequest(
        targetType: _targetType, targetId: _targetId, dataType: null);

    _attachRequest(request);

    if (_text != null) {
      CreatePostData data = CreatePostData();
      data.text = _text;
      request.data = data;
    }

    if (_metadata != null) {
      request.metadata = _metadata;
    }

    return _useCase.get(request);
  }
}
