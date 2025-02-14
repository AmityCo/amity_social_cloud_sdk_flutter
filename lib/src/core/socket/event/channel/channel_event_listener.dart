import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core_client.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/socket/event/socket_event_listener.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/usecase/channel/channel_has_local_usecase.dart';

abstract class ChannelEventListener extends SocketEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateChannelResponse.fromJson(json);

    data.saveToDb(serviceLocator());
  }

  /// This method is used to check if the event should be processed or not.
  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = CreateChannelResponse.fromJson(json);
    if (data.channels.isNotEmpty) {
      return _hasInLocal(data.channels[0].channelId);
    } else {
      return false;
    }
  }

  bool _hasInLocal(String channelId) {
    return serviceLocator<ChannelHasLocalUsecase>().get(channelId);
  }

  bool isActiveUserAddedEvent(CreateChannelResponse data) {
    return isActiveUserEvent(data, (membership) => 
      membership.membership == AmityMembershipType.MEMBER.value
    );
  }
  
  bool isActiveUserRemovedEvent(CreateChannelResponse data) {
    return isActiveUserEvent(data, (membership) => 
      membership.membership == AmityMembershipType.NONE.value || 
      membership.membership == AmityMembershipType.BANNED.value
    );
  }

  bool isActiveUserEvent(CreateChannelResponse data, bool Function(ChannelUserResponse membership) condition) {
    final activeUserId = CoreClient.getUserId();
    for (var membership in data.channelUsers) {
      if (condition(membership) && membership.userId == activeUserId) {
        return true;
      }
    }
    return false;
  }
}
