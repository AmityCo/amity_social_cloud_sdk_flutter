// ignore_for_file: unused_field

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Post Creator Query Builder
class AmityPostCreateTargetSelector {
  late PostCreateUsecase _useCase;

  /// Init [AmityPostCreateTargetSelector]
  AmityPostCreateTargetSelector({required PostCreateUsecase useCase}) {
    _useCase = useCase;
  }

  /// Target the current user for Amity Post
  AmityPostCreateDataTypeSelector targetMe() {
    return AmityPostCreateDataTypeSelector(
        useCase: _useCase,
        userId: AmityCoreClient.getUserId(),
        targetType: AmityPostTargetType.USER);
  }

  /// Taget the user Id for the Amity Post
  AmityPostCreateDataTypeSelector targetUser(String targetUser) {
    return AmityPostCreateDataTypeSelector(
        useCase: _useCase,
        userId: targetUser,
        targetType: AmityPostTargetType.USER);
  }

  /// Target the community for the Amity Post
  AmityPostCreateDataTypeSelector targetCommunity(String communityId) {
    return AmityPostCreateDataTypeSelector(
        useCase: _useCase,
        userId: communityId,
        targetType: AmityPostTargetType.COMMUNITY);
  }
}

/// Amity Post Data Type Selector Query Builder
class AmityPostCreateDataTypeSelector {
  late PostCreateUsecase _useCase;
  late String _userId;
  late AmityPostTargetType _targetType;

  /// Init [AmityPostCreateDataTypeSelector]
  AmityPostCreateDataTypeSelector(
      {required PostCreateUsecase useCase,
      required String userId,
      required AmityPostTargetType targetType}) {
    _useCase = useCase;
    _userId = userId;
    _targetType = targetType;
  }

  /// Data Type Text
  AmityTextPostCreator text(String text) {
    return AmityTextPostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        text: text);
  }

  /// Data Type Image
  AmityImagePostCreator image(List<AmityImage> images) {
    return AmityImagePostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        images: images);
  }

  /// Data Type Video
  AmityVideoPostCreator video(List<AmityVideo> videos) {
    return AmityVideoPostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        videos: videos);
  }

  /// Data Type File
  AmityFilePostCreator file(List<AmityFile> files) {
    return AmityFilePostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        files: files);
  }

  /// Data Type Poll
  AmityPollPostCreator poll(String pollId) {
    return AmityPollPostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        pollId: pollId);
  }
}

/// Implementation Layer for Amity Post Text Creator
class AmityTextPostCreator extends PostCreator {
  /// Init [AmityTextPostCreator]
  AmityTextPostCreator(
      {required PostCreateUsecase useCase,
      required String targetId,
      required String targetType,
      required String text})
      : super(useCase: useCase, targetId: targetId, targetType: targetType) {
    _text = text;
  }
}

/// Implementation Layer for Amity Post Image Creator
class AmityImagePostCreator extends PostCreator {
  late final List<AmityImage> _images;

  /// Init [AmityImagePostCreator]
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

/// Implementation Layer for Amity Post File Creator
class AmityFilePostCreator extends PostCreator {
  late final List<AmityFile> _files;

  /// Init [AmityFilePostCreator]
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

/// Implementation Layer for Amity Post Video Creator
class AmityVideoPostCreator extends PostCreator {
  late final List<AmityVideo> _videos;

  /// Init [AmityVideoPostCreator]
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

/// Implementation Layer for Amity Post Poll Creator
class AmityPollPostCreator extends PostCreator {
  /// Init [AmityPollPostCreator]
  AmityPollPostCreator(
      {required PostCreateUsecase useCase,
      required String targetId,
      required String targetType,
      required String pollId})
      : super(useCase: useCase, targetId: targetId, targetType: targetType) {
    _pollId = pollId;
  }
}

/// Abstract Layer for Amity Post Creator
abstract class PostCreator {
  late PostCreateUsecase _useCase;
  late String _targetId;
  late String _targetType;
  String? _text;
  String? _pollId;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;

  /// Init [PostCreator]
  PostCreator({
    required PostCreateUsecase useCase,
    required String targetId,
    required String targetType,
  }) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
  }

  /// Add text to Amity Post
  PostCreator text(String text) {
    _text = text;
    return this;
  }

  /// Add metadata to Amity Post
  PostCreator metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  void _attachRequest(CreatePostRequest request) {}

  /// Create Amity Post
  Future<AmityPost> post() {
    CreatePostRequest request = CreatePostRequest(
        targetType: _targetType, targetId: _targetId, dataType: null);

    _attachRequest(request);

    if (_text != null || _pollId != null) {
      CreatePostData data = CreatePostData();
      if (_text != null) data.text = _text;
      if (_pollId != null) {
        data.pollId = _pollId;
        request.dataType = 'poll';
      }
      request.data = data;
    }

    if (_metadata != null) {
      request.metadata = _metadata;
    }

    return _useCase.get(request);
  }
}
