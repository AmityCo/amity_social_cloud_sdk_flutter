// ignore_for_file: unused_field

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/public.dart';

/// Amity Message Update Query Builder
class AmityMessageUpdateQueryBuilder {
  late final MessageUpdateUsecase _useCase;

  final String channelId;
  final String messageId;

  List<String>? _amityTags;
  Map<String, dynamic>? _metadata;
  String? _text;

  /// Init [AmityMessageCreateTargetSelector]
  AmityMessageUpdateQueryBuilder(
      {required MessageUpdateUsecase useCase,
      required this.channelId,
      required this.messageId})
      : _useCase = useCase;

  AmityMessageUpdateQueryBuilder text(String text) {
    _text = text;
    return this;
  }

  AmityMessageUpdateQueryBuilder tags(List<String> tags) {
    _amityTags = tags;
    return this;
  }

  AmityMessageUpdateQueryBuilder metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  /// Update Amity Message
  Future<AmityMessage> update() async {
    CreateMessageRequest request =
        CreateMessageRequest(channelId: channelId, messageId: messageId);

    if (_text != null) {
      request.data = CreateMessageData(text: _text);
    }

    if (_amityTags != null) {
      request.tags = _amityTags;
    }

    if (_metadata != null) {
      request.metadata = _metadata;
    }

    // Added the userId
    request.userId = AmityCoreClient.getUserId();

    return _useCase.get(request);
  }
}
