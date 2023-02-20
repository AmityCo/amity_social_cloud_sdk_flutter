import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/query_builder/message/message_flag_query_builder.dart';

/// [MessageRepository]
class MessageRepository {
  /// Get Messages
  MessageGetQueryBuilder getMessages(String channelId) {
    return MessageGetQueryBuilder(
        serviceLocator<MessageQueryUseCase>(), channelId);
  }

  /// Get Messages
  Future<AmityMessage> getMessage(String messageId) {
    return serviceLocator<MessageGetUseCase>().get(messageId);
  }

  /// Create Message
  AmityMessageCreateDataTypeSelector createMessage(String channelId) {
    return AmityMessageCreateTargetSelector(
            useCase: serviceLocator<MessageCreateUsecase>())
        .channelId(channelId);
  }

  /// Create Message
  AmityMessageUpdateQueryBuilder updateMessage(
      String channelId, String messageId) {
    return AmityMessageUpdateQueryBuilder(
        useCase: serviceLocator<MessageUpdateUsecase>(),
        channelId: channelId,
        messageId: messageId);
  }

  /// Delete message
  Future deleteMessage(String messageId) {
    return serviceLocator<MessageDeleteUsecase>().get(messageId);
  }

  /// Get [AmityReaction] for the message Id
  GetReactionQueryBuilder getReaction({required String messageId}) {
    return GetReactionQueryBuilder.message(messageId: messageId);
  }

  /// flag message
  Future<AmityMessage> flag(String messageId) {
    return MessageFlagQueryBuilder(
            messageFlagUsecase: serviceLocator(),
            messageUnflagUsecase: serviceLocator(),
            messageId: messageId)
        .flag();
  }

  /// unflag message
  Future<AmityMessage> unflag(String messageId) {
    return MessageFlagQueryBuilder(
            messageFlagUsecase: serviceLocator(),
            messageUnflagUsecase: serviceLocator(),
            messageId: messageId)
        .unflag();
  }
}
