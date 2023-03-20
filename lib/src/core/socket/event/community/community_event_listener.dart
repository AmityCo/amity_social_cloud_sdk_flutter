import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/socket/event/socket_event_listener.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

///[PostEventListener]
abstract class CommunityEventListener extends SocketEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateCommunityResponse.fromJson(json);

    data.saveToDb(serviceLocator());
  }

  /// This method is used to check if the event should be processed or not.
  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = CreateCommunityResponse.fromJson(json);
    if (data.communities.isNotEmpty) {
      return _hasLocalCommunity(data.communities[0].communityId);
    } else {
      return false;
    }
  }

  bool _hasLocalCommunity(String communityId) {
    return serviceLocator<CommunityHasLocalUsecase>().get(communityId);
  }
}
