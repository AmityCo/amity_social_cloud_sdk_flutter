import 'package:amity_sdk/src/core/core.dart';

/// [CommunityUserBannedEventListener]
class CommunityUserBannedEventListener extends CommunityMemberEventListener {
  @override
  String getEventName() {
    return 'community.userBanned';
  }
}
