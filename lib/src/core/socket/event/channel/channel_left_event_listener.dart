import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/socket/event/channel/channel_event_listener.dart';
import 'package:amity_sdk/src/data/response/response.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class ChannelLeftEventListener extends ChannelEventListener {
  @override
  String getEventName() {
    return 'channel.left';
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    if (!isActiveUserRemovedEvent(CreateChannelResponse.fromJson(json))) {
      json
        ..['channels'] = (json['channels'] as List).map((channel) {
          var channelId = ChannelResponse.fromJson(channel).channelId;
          channel['messagePreviewId'] =
              serviceLocator<ChannelRepo>().getMessagePreviewId(channelId);
          return channel;
        }).toList();
    }
    super.processEvent(json);
  }
}
