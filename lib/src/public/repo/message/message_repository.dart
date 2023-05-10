import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [MessageRepository]
class MessageRepository {
  /*  begin_public_function
  id: message.query
  */
  /// Get Messages
  MessageGetQueryBuilder getMessages(String channelId) {
    return MessageGetQueryBuilder(serviceLocator<MessageQueryUseCase>(), channelId);
  }
  /* end_public_function */

  /*  begin_public_function
  id: message.get
  */
  /// Get Messages
  Future<AmityMessage> getMessage(String messageId) {
    return serviceLocator<MessageGetUseCase>().get(messageId);
  }
  /* end_public_function */

  /*  begin_public_function
  id: message.create.text_message, message.create.image_message, message.create.file_message
  api_style: async
  */
  /// Create Message
  AmityMessageCreateDataTypeSelector createMessage(String channelId) {
    return AmityMessageCreateTargetSelector(useCase: serviceLocator<MessageCreateUsecase>()).channelId(channelId);
  }
  /* end_public_function */

  /*  begin_public_function
  id: message.edit
  api_style: async
  */
  /// Create Message
  AmityMessageUpdateQueryBuilder updateMessage(String channelId, String messageId) {
    return AmityMessageUpdateQueryBuilder(
        useCase: serviceLocator<MessageUpdateUsecase>(), channelId: channelId, messageId: messageId);
  }
  /* end_public_function */

  /*  begin_public_function
  id: message.soft_delete
  */
  /// Delete message
  Future deleteMessage(String messageId) {
    return serviceLocator<MessageDeleteUsecase>().get(messageId);
  }
  /* end_public_function */

  /// Get [AmityReaction] for the message Id
  GetReactionQueryBuilder getReaction({required String messageId}) {
    return GetReactionQueryBuilder.message(messageId: messageId);
  }

  /*  begin_public_function
  id: message.flag
  */
  /// flag message
  Future<AmityMessage> flag(String messageId) {
    return MessageFlagQueryBuilder(
            messageFlagUsecase: serviceLocator(), messageUnflagUsecase: serviceLocator(), messageId: messageId)
        .flag();
  }
  /* end_public_function */

  /*  begin_public_function
  id: message.unflag
  */
  /// unflag message
  Future<AmityMessage> unflag(String messageId) {
    return MessageFlagQueryBuilder(
            messageFlagUsecase: serviceLocator(), messageUnflagUsecase: serviceLocator(), messageId: messageId)
        .unflag();
  }
  /* end_public_function */
}
