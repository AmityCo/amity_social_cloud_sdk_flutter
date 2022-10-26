import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_create_use_case.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_query_use_case.dart';
import 'package:amity_sdk/src/public/public.dart';

/// [MessageRepository]
class MessageRepository {
  /// Get Messages
  MessageGetQueryBuilder getMessages(String channelId) {
    return MessageGetQueryBuilder(
        serviceLocator<MessageQueryUseCase>(), channelId);
  }

  /// Create Message
  AmityMessageCreateDataTypeSelector createMessage(String channelId) {
    return AmityMessageCreateTargetSelector(
            useCase: serviceLocator<MessageCreateUsecase>())
        .channelId(channelId);
  }

  /// Get [AmityReaction] for the message Id
  GetReactionQueryBuilder getReaction({required String messageId}) {
    return GetReactionQueryBuilder.message(messageId: messageId);
  }
}
