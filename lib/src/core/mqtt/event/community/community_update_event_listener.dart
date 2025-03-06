import 'package:amity_sdk/src/core/core.dart';

/// [CommunityUpdateEventListener]
class CommunityUpdateEventListener extends CommunityEventListener {
  @override
  String getEventName() {
    return 'community.updated';
  }
}
