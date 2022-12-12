import 'package:amity_sdk/src/domain/domain.dart';

/// Message Repor Query Builder
class MessageFlagQueryBuilder {
  final MessageFlagUsecase _messageFlagUsecase;
  final MessageUnflagUsecase _messageUnflagUsecase;
  final String _messageId;

  /// Init [MessageFlagQueryBuilder]
  MessageFlagQueryBuilder(
      {required MessageFlagUsecase messageFlagUsecase,
      required MessageUnflagUsecase messageUnflagUsecase,
      required String messageId})
      : _messageFlagUsecase = messageFlagUsecase,
        _messageUnflagUsecase = messageUnflagUsecase,
        _messageId = messageId;

  /// Flag Message
  Future<AmityMessage> flag() {
    return _messageFlagUsecase.get(_messageId);
  }

  /// Unflag Message
  Future<AmityMessage> unflag() {
    return _messageUnflagUsecase.get(_messageId);
  }
}
