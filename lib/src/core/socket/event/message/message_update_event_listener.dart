import 'package:amity_sdk/src/core/core.dart';

/// [MessageUpdateEventListener]
class MessageUpdateEventListener extends MessageEventListener {
  @override
  String getEventName() {
    return 'v3.message.didUpdate';
  }
}
