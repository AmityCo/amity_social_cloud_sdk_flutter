import 'package:amity_sdk/src/core/core.dart';

/// [CommunityJoinEventListener]
class CommunityJoinEventListener extends CommunityMemberEventListener {
  @override
  String getEventName() {
    return 'community.joined';
  }
}
