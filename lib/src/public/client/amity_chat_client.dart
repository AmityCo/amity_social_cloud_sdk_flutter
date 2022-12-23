import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/public/repo/channel/amity_channel_repository.dart';
import 'package:amity_sdk/src/public/repo/message/message_repository.dart';

/// [AmityChatClient]
class AmityChatClient {
  /// [MessageRepository]
  static MessageRepository newMessageRepository() {
    return serviceLocator<MessageRepository>();
  }

  /// [AmityChannelRepository]
  static AmityChannelRepository newChannelRepository() {
    return serviceLocator<AmityChannelRepository>();
  }
}
