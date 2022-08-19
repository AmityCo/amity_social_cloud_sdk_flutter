// ignore_for_file: unused_field

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_message_type.dart';
import 'package:amity_sdk/src/core/model/api_request/create_message_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/message/amity_message.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_create_use_case.dart';
import 'package:amity_sdk/src/public/public.dart';
import 'package:uuid/uuid.dart';

/// Amity Post Creator Query Builder
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
    return AmityMessageCreateDataTypeSelector(
        useCase: _useCase, channelId: _channelId!);
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

/// Amity Post Data Type Selector Query Builder
class AmityMessageCreateDataTypeSelector {
  late MessageCreateUsecase _useCase;
  late String _channelId;
  String? _parentId;

  /// Init [AmityMessageCreateDataTypeSelector]
  AmityMessageCreateDataTypeSelector(
      {required MessageCreateUsecase useCase, required String channelId}) {
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
    return AmityTextMessageCreator(
        useCase: _useCase, channelId: _channelId, text: text)
      ..parentId(_parentId);
  }

  // /// Data Type Image
  // AmityImagePostCreator image(List<AmityImage> images) {
  //   return AmityImagePostCreator(
  //       useCase: _useCase,
  //       targetId: _userId,
  //       targetType: _targetType.value,
  //       images: images);
  // }

  // /// Data Type Video
  // AmityVideoPostCreator video(List<AmityVideo> videos) {
  //   return AmityVideoPostCreator(
  //       useCase: _useCase,
  //       targetId: _userId,
  //       targetType: _targetType.value,
  //       videos: videos);
  // }

  // /// Data Type File
  // AmityFilePostCreator file(List<AmityFile> files) {
  //   return AmityFilePostCreator(
  //       useCase: _useCase,
  //       targetId: _userId,
  //       targetType: _targetType.value,
  //       files: files);
  // }

  // /// Data Type Poll
  // AmityPollPostCreator poll(String pollId) {
  //   return AmityPollPostCreator(
  //       useCase: _useCase,
  //       targetId: _userId,
  //       targetType: _targetType.value,
  //       pollId: pollId);
  // }
}

/// Implementation Layer for Amity Post Text Creator
class AmityTextMessageCreator extends AmityMessageCreator {
  /// Text
  String text;

  /// Init [AmityTextPostCreator]
  AmityTextMessageCreator(
      {required MessageCreateUsecase useCase,
      required String channelId,
      String? parentId,
      required this.text})
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

/// Implementation Layer for Amity Post Image Creator
// class AmityImagePostCreator extends AmityMessageCreator {
//   late final List<AmityImage> _images;

//   /// Init [AmityImagePostCreator]
//   AmityImagePostCreator({
//     required List<AmityImage> images,
//     required MessageCreateUsecase useCase,
//     required String channelId,
//     String? parentId,
//   }) : super(useCase: useCase, channelId: channelId, parentId: parentId) {
//     _images = images;
//   }

//   @override
//   void _attachRequest(CreatePostRequest request) {
//     request.attachments = _images
//         .map((e) =>
//             Attachment(fileId: e.fileId, type: AmityDataType.IMAGE.value))
//         .toList();
//   }
// }

/// Implementation Layer for Amity Post File Creator
// class AmityFilePostCreator extends AmityMessageCreator {
//   late final List<AmityFile> _files;

//   /// Init [AmityFilePostCreator]
//   AmityFilePostCreator({
//     required List<AmityFile> files,
//     required MessageCreateUsecase useCase,
//     required String channelId,
//     String? parentId,
//   }) : super(useCase: useCase, channelId: channelId, parentId: parentId) {
//     _files = files;
//   }

//   @override
//   void _attachRequest(CreatePostRequest request) {
//     request.attachments = _files
//         .map(
//             (e) => Attachment(fileId: e.fileId, type: AmityDataType.FILE.value))
//         .toList();
//   }
// }

/// Abstract Layer for Amity Post Creator
abstract class AmityMessageCreator {
  late MessageCreateUsecase _useCase;
  late String _channelId;
  String? _parentId;
  AmityTags? _amityTags;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;

  /// Init [PostCreator]
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

  /// Add metadata to Amity Post
  AmityMessageCreator parentId(String? parentId) {
    _parentId = parentId;
    return this;
  }

  /// Add metadata to Amity Post
  AmityMessageCreator metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  /// Metion Users
  AmityMessageCreator mentionUsers(List<String> userIds) {
    _mentionees ??= [];
    _mentionees!.add(AmityMentioneeTarget(
        type: AmityMentionType.USER.value, userIds: userIds));
    return this;
  }

  /// Metion Channel
  AmityMessageCreator mentionChannel() {
    _mentionees ??= [];
    _mentionees!.add(AmityMentioneeTarget(
        type: AmityMentionType.CHANNEL.value, userIds: [_channelId]));
    return this;
  }

  /// Tags
  AmityMessageCreator tags(AmityTags tags) {
    _amityTags = tags;
    return this;
  }

  /// Create Amity Post
  Future<AmityMessage> send() {
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

    return _useCase.get(request);
  }
}
