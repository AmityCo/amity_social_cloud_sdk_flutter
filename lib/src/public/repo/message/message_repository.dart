import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/usecase/message/message_query_use_case.dart';
import 'package:amity_sdk/src/public/query_builder/message/get_message_query_builder.dart';

/// [MessageRepository]
class MessageRepository {
  /// Get Messages
  GetMessageQueryBuilder getMessages(String channelId) {
    return GetMessageQueryBuilder(
        serviceLocator<MessageQueryUseCase>(), channelId);
  }

  // fun getMessage(messageId: String): Flowable<AmityMessage> {
  //     return GetMessageUseCase().execute(messageId)
  // }
}
