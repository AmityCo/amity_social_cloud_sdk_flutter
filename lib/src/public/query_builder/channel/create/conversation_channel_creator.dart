import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';

class ConversationChannelCreator {
  ChannelCreatorBuilder withUserId(String userId) {
    return ChannelCreatorBuilder(
        serviceLocator(), AmityChannelType.CONVERSATION)
      ..userIds([userId]);
  }

  ChannelCreatorBuilder withUserIds(List<String> userIds) {
    return ChannelCreatorBuilder(
        serviceLocator(), AmityChannelType.CONVERSATION)
      ..userIds(userIds);
  }
}
