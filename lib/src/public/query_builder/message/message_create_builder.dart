// ignore_for_file: unused_field

import 'dart:io';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';
import 'package:uuid/uuid.dart';

/// Amity Mesage Creator Query Builder
class AmityMessageCreateTargetSelector {
  late MessageCreateUsecase _useCase;

  String? _channelId;
  String? _parentId;

  /// Init [AmityMessageCreateTargetSelector]
  AmityMessageCreateTargetSelector({required MessageCreateUsecase useCase}) {
    _useCase = useCase;
  }

  /// Channel ID
  AmityMessageCreateDataTypeSelector channelId(String channelId) {
    _channelId = channelId;
    return AmityMessageCreateDataTypeSelector(useCase: _useCase, channelId: _channelId!);
  }

  // AmityMessageCreateTargetSelector parentId(String parentId) {
  //   _parentId = parentId;
  //   return this;
  // }

  // AmityMessageCreateDataTypeSelector build() {
  //   return AmityMessageCreateDataTypeSelector(
  //       useCase: _useCase, channelId: _channelId!)
  //     ..parentId(_parentId);
  // }
}

/// Amity Mesage Data Type Selector Query Builder
class AmityMessageCreateDataTypeSelector {
  late MessageCreateUsecase _useCase;
  late String _channelId;
  String? _parentId;

  /// Init [AmityMessageCreateDataTypeSelector]
  AmityMessageCreateDataTypeSelector({required MessageCreateUsecase useCase, required String channelId}) {
    _useCase = useCase;
    _channelId = channelId;
  }

  /// Parent ID
  AmityMessageCreateDataTypeSelector parentId(String? parentId) {
    _parentId = parentId;
    return this;
  }

  /// Data Type Text
  AmityTextMessageCreator text(String text) {
    return AmityTextMessageCreator(useCase: _useCase, channelId: _channelId, text: text)..parentId(_parentId);
  }

  /// Data Type Image
  AmityImageMessageCreator image(Uri uri) {
    return AmityImageMessageCreator(
      useCase: _useCase,
      channelId: _channelId,
      uri: uri,
    );
  }

  /// Data Type file
  AmityFileMessageCreator file(Uri uri) {
    return AmityFileMessageCreator(
      useCase: _useCase,
      channelId: _channelId,
      uri: uri,
    );
  }

  // /// Data Type Video
  // AmityVideoMesageCreator video(List<AmityVideo> videos) {
  //   return AmityVideoMesageCreator(
  //       useCase: _useCase,
  //       targetId: _userId,
  //       targetType: _targetType.value,
  //       videos: videos);
  // }

  // /// Data Type File
  // AmityFileMesageCreator file(List<AmityFile> files) {
  //   return AmityFileMesageCreator(
  //       useCase: _useCase,
  //       targetId: _userId,
  //       targetType: _targetType.value,
  //       files: files);
  // }

  // /// Data Type Poll
  // AmityPollMesageCreator poll(String pollId) {
  //   return AmityPollMesageCreator(
  //       useCase: _useCase,
  //       targetId: _userId,
  //       targetType: _targetType.value,
  //       pollId: pollId);
  // }
}

/// Implementation Layer for Amity Mesage Text Creator
class AmityTextMessageCreator extends AmityMessageCreator {
  /// Text
  String text;

  /// Init [AmityTextMesageCreator]
  AmityTextMessageCreator(
      {required MessageCreateUsecase useCase, required String channelId, String? parentId, required this.text})
      : super(useCase: useCase, channelId: channelId);

  @override
  CreateMessageData getData() {
    return CreateMessageData(text: text);
  }

  @override
  AmityMessageDataType getDataType() {
    return AmityMessageDataType.TEXT;
  }
}

/// Implementation Layer for Amity Mesage Text Creator
class AmityImageMessageCreator extends AmityMessageCreator {
  /// Image uri
  Uri uri;

  /// Caption
  String? _caption;

  /// Init [AmityTextMesageCreator]
  AmityImageMessageCreator(
      {required MessageCreateUsecase useCase, required String channelId, String? parentId, required this.uri})
      : super(useCase: useCase, channelId: channelId);

  /// Add Caption to image
  AmityImageMessageCreator caption(String caption) {
    _caption = caption;
    return this;
  }

  @override
  CreateMessageData getData() {
    return CreateMessageData(caption: _caption);
  }

  @override
  AmityMessageDataType getDataType() {
    return AmityMessageDataType.IMAGE;
  }

  @override
  Uri? getUri() {
    return uri;
  }
}

/// Implementation Layer for Amity Message File Creator
class AmityFileMessageCreator extends AmityMessageCreator {
  /// Image uri
  Uri uri;

  /// Caption
  String? _caption;

  /// Init [AmityTextMesageCreator]
  AmityFileMessageCreator(
      {required MessageCreateUsecase useCase, required String channelId, String? parentId, required this.uri})
      : super(useCase: useCase, channelId: channelId);

  /// Add Caption to image
  AmityFileMessageCreator caption(String caption) {
    _caption = caption;
    return this;
  }

  @override
  CreateMessageData getData() {
    return CreateMessageData(caption: _caption);
  }

  @override
  AmityMessageDataType getDataType() {
    return AmityMessageDataType.FILE;
  }

  @override
  Uri? getUri() {
    return uri;
  }
}

/// Abstract Layer for Amity Mesage Creator
abstract class AmityMessageCreator {
  late MessageCreateUsecase _useCase;
  late String _channelId;
  String? _parentId;
  AmityTags? _amityTags;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;

  /// Init [MesageCreator]
  AmityMessageCreator({
    required MessageCreateUsecase useCase,
    required String channelId,
  }) {
    _useCase = useCase;
    _channelId = channelId;
  }

  /// Get Data
  CreateMessageData getData();

  /// Get Data Type
  AmityMessageDataType getDataType();

  /// Get File Uri
  Uri? getUri() {
    return null;
  }

  /// Add metadata to Amity Mesage
  AmityMessageCreator parentId(String? parentId) {
    _parentId = parentId;
    return this;
  }

  /// Add metadata to Amity Mesage
  AmityMessageCreator metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  /// Metion Users
  AmityMessageCreator mentionUsers(List<String> userIds) {
    _mentionees ??= [];
    _mentionees!.add(AmityMentioneeTarget(type: AmityMentionType.USER.value, userIds: userIds));
    return this;
  }

  /// Metion Channel
  AmityMessageCreator mentionChannel() {
    _mentionees ??= [];
    _mentionees!.add(AmityMentioneeTarget(type: AmityMentionType.CHANNEL.value));
    return this;
  }

  /// Tags
  /// Future Use
  // AmityMessageCreator tags(List<String> tags) {
  //   _amityTags = AmityTags(tags: tags);
  //   return this;
  // }

  /// Create Amity Mesage
  Future<AmityMessage> send() async {
    // throw UnimplementedError();

    CreateMessageRequest request = CreateMessageRequest(channelId: _channelId);

    if (_parentId != null) {
      request.parentId = _parentId!;
    }

    request.type = getDataType().value;

    request.data = getData();

    if (_mentionees != null) {
      request.mentionees = _mentionees!;
    }

    if (_amityTags != null) {
      request.tags = _amityTags!.tags;
    }

    if (_metadata != null) {
      request.metadata = _metadata;
    }

    // Added the Message Id
    request.messageId = Uuid().v4();

    // Added the userId
    request.userId = AmityCoreClient.getUserId();

    if (getDataType() == AmityMessageDataType.IMAGE || getDataType() == AmityMessageDataType.FILE) {
      /// set file Uri

      request.uri = File(getUri()!.toFilePath());
      return serviceLocator<MessageCreateFileUsecase>().get(request);
    }

    return _useCase.get(request);
  }
}
