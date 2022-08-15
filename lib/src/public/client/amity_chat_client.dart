import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/public/repo/message/message_repository.dart';

/// [AmityChatClient]
class AmityChatClient {
  /// Message Repository
  static MessageRepository newMessageRepository() {
    return serviceLocator<MessageRepository>();
  }
}
