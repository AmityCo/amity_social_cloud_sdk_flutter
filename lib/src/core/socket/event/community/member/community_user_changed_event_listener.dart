import 'package:amity_sdk/src/core/core.dart';

/// [CommunityUserChangedEventListener]
class CommunityUserChangedEventListener extends CommunityMemberEventListener {
  @override
  String getEventName() {
    return 'community.userChanged';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) => false;
}
