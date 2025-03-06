import 'package:amity_sdk/src/core/core.dart';

/// [CommunityUserAddedEventListener]
class CommunityUserAddedEventListener extends CommunityMemberEventListener {
  @override
  String getEventName() {
    return 'community.userAdded';
  }
}
