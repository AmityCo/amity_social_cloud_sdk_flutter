import 'package:amity_sdk/src/core/core.dart';

/// [CommunityLeftEventListener]
class CommunityLeftEventListener extends CommunityMemberEventListener {
  @override
  String getEventName() {
    return 'community.left';
  }
}
