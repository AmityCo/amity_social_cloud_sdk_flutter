import 'package:amity_sdk/src/core/core.dart';

/// [CommunityCreateEventListener]
class CommunityCreateEventListener extends CommunityEventListener {
  @override
  String getEventName() {
    return 'community.created';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}
