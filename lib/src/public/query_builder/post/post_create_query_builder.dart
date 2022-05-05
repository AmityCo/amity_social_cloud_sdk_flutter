import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_file.dart';
import 'package:amity_sdk/src/domain/model/amity_mentionee_target.dart';
import 'package:amity_sdk/src/domain/model/amity_post.dart';
import 'package:amity_sdk/src/domain/usecase/post/post_create_usecase.dart';
import 'package:amity_sdk/src/public/amity_core_client.dart';

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

  AmityCommunityFeedPostCreator targetCommunity(String communityId) {
    return AmityCommunityFeedPostCreator();
  }

  // PostCreateQueryBuilder text(String text) {
  //   _text = text;
  //   return this;
  // }

  // Future post() {
  //   throw UnimplementedError();
  // }
}

//Target
// class AmityMyFeedPostCreator {}

// class AmityUserFeedPostCreator {
//   late String _userId;
//   AmityUserFeedPostCreator({required String userId}) {
//     _userId = userId;
//   }
// }

class AmityCommunityFeedPostCreator {}

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
        video: videos);
  }

  AmityFilePostCreator file(List<AmityFile> files) {
    return AmityFilePostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        files: files);
  }
}

class AmityTextPostCreator {
  late PostCreateUsecase _useCase;
  late String _targetId;
  late String _targetType;
  late String _text;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityTextPostCreator(
      {required PostCreateUsecase useCase,
      required String targetId,
      required String targetType,
      required String text}) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
    _text = text;
  }

  Future<AmityPost> post() {
    CreatePostRequest request = CreatePostRequest(
        targetType: _targetType, targetId: _targetId, dataType: null);

    CreatePostData data = CreatePostData();
    data.text = _text;

    request.data = data;

    return _useCase.get(request);
  }
}

class AmityImagePostCreator {
  late PostCreateUsecase _useCase;
  late String _targetId;
  late String _targetType;
  String? _text;
  late List<AmityImage> _images;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityImagePostCreator(
      {required PostCreateUsecase useCase,
      required String targetId,
      required String targetType,
      required List<AmityImage> images}) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
    _images = images;
  }

  AmityImagePostCreator text(String text) {
    _text = text;
    return this;
  }

  Future<AmityPost> post() {
    CreatePostRequest request = CreatePostRequest(
        targetType: _targetType, targetId: _targetId, dataType: null);

    request.attachments = _images
        .map((e) =>
            Attachment(fileId: e.fileId, type: AmityDataType.IMAGE.value))
        .toList();

    if (_text != null) {
      CreatePostData data = CreatePostData();
      data.text = _text;
      request.data = data;
    }

    return _useCase.get(request);
  }
}

class AmityFilePostCreator {
  late final PostCreateUsecase _useCase;
  late final String _targetId;
  late final String _targetType;
  String? _text;
  late final List<AmityFile> _files;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityFilePostCreator(
      {required PostCreateUsecase useCase,
      required String targetId,
      required String targetType,
      required List<AmityFile> files})
      : _useCase = useCase,
        _targetId = targetId,
        _targetType = targetType,
        _files = files;

  AmityFilePostCreator text(String text) {
    _text = text;
    return this;
  }

  Future<AmityPost> post() {
    CreatePostRequest request = CreatePostRequest(
        targetType: _targetType, targetId: _targetId, dataType: null);

    request.attachments = _files
        .map(
            (e) => Attachment(fileId: e.fileId, type: AmityDataType.FILE.value))
        .toList();

    if (_text != null) {
      CreatePostData data = CreatePostData();
      data.text = _text;
      request.data = data;
    }

    return _useCase.get(request);
  }
}

class AmityVideoPostCreator {
  late PostCreateUsecase _useCase;
  late String _targetId;
  late String _targetType;
  String? _text;
  late List<AmityVideo> _videos;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityVideoPostCreator(
      {required PostCreateUsecase useCase,
      required String targetId,
      required String targetType,
      required List<AmityVideo> video}) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
    _videos = video;
  }

  AmityVideoPostCreator text(String text) {
    _text = text;
    return this;
  }

  Future<AmityPost> post() {
    CreatePostRequest request = CreatePostRequest(
        targetType: _targetType, targetId: _targetId, dataType: null);

    request.attachments = _videos
        .map((e) =>
            Attachment(fileId: e.fileId, type: AmityDataType.VIDEO.value))
        .toList();

    if (_text != null) {
      CreatePostData data = CreatePostData();
      data.text = _text;
      request.data = data;
    }

    return _useCase.get(request);
  }
}
