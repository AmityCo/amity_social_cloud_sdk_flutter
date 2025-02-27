import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/core/mqtt/event/channel/channel_event_listener.dart';
import 'package:amity_sdk/src/data/data.dart';

class ChannelCreatedEventListener extends ChannelEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateChannelResponse.fromJson(json);
    final myUserId = CoreClient.getUserId();
    var hasMyMembership = data.channelUsers
        .where((element) => element.userId == myUserId)
        .isNotEmpty;
    if (!hasMyMembership) {
      // Assume being member on channel created event
      data.channelUsers.add(ChannelUserResponse(
        id: '',
        channelId: data.channels.firstOrNull?.channelId ?? "",
        membership: "member",
        isBanned: false,
        lastActivity: DateTime.now(),
        roles: [],
        permissions: [],
        readToSegment: 0,
        lastMentionedSegment: 0,
        isMuted: false,
        muteTimeout: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: myUserId,
      ));
    }
    super.processEvent(data.toJson());
  }

  @override
  String getEventName() {
    return 'channel.created';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}
