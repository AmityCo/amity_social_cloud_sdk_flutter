import 'package:amity_sdk/src/core/core.dart';

/// [CommunityUserRemovedEventListener]
class CommunityUserRemovedEventListener extends CommunityMemberEventListener {
  @override
  String getEventName() {
    return 'community.userRemoved';
  }
}
