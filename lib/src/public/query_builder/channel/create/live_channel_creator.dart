import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/public.dart';

class LiveChannelCreator {
  ChannelCreatorBuilder withChannelId(String channelId) {
    return ChannelCreatorBuilder(serviceLocator(), AmityChannelType.LIVE)
      ..channelId(channelId);
  }

  ChannelCreatorBuilder withDisplayName(String displayName) {
    return ChannelCreatorBuilder(serviceLocator(), AmityChannelType.LIVE)
      ..displayName(displayName);
  }
}
