import 'package:amity_sdk/src/core/core.dart';

///[MessageDeleteventListener]
class MessageDeleteventListener extends MessageEventListener {
  @override
  String getEventName() {
    return 'v3.message.didDelete';
  }
}
