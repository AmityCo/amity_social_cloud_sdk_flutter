import 'package:amity_sdk/src/core/core.dart';

/// [CommunityRoleRemovedEventListener]
class CommunityRoleRemovedEventListener extends CommunityMemberEventListener {
  @override
  String getEventName() {
    return 'community.roleRemoved';
  }
}
