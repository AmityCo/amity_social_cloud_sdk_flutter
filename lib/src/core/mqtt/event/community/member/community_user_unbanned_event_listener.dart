import 'package:amity_sdk/src/core/core.dart';

/// [CommunityUserUnbannedEventListener]
class CommunityUserUnbannedEventListener extends CommunityMemberEventListener {
  @override
  String getEventName() {
    return 'community.userUnbanned';
  }
}
