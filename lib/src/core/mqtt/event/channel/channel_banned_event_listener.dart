import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_event_listener.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class ChannelBannedEventListener extends ChannelEventListener {

  @override
  String getEventName() {
    return 'channel.banned';
  }

  @override
  void processEvent(Map<String, dynamic> json) {
    super.processEvent(json);
    final data = CreateChannelResponse.fromJson(json);
    final channelMemberRepo = serviceLocator<ChannelMemberRepo>();
    for (var membership in data.channelUsers) {
      channelMemberRepo.handleMembershipBan(membership.channelId, membership.userId);
    }

  }
}
