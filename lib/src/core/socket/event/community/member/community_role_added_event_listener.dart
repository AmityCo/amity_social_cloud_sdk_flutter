import 'package:amity_sdk/src/core/core.dart';

/// [CommunityRoleAddedEventListener]
class CommunityRoleAddedEventListener extends CommunityMemberEventListener {
  @override
  String getEventName() {
    return 'community.roleAdded';
  }
}
