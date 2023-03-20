import 'package:amity_sdk/src/core/core.dart';

/// [CommunityDeleteEventListener]
class CommunityDeleteEventListener extends CommunityEventListener {
  @override
  String getEventName() {
    return 'comunity.deleted';
  }
}
