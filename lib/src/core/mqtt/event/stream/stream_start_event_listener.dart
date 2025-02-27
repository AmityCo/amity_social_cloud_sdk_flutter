import 'package:amity_sdk/src/core/mqtt/event/stream/stream_event_listener.dart';

class StreamStartEventListener extends StreamEventListener{
  @override
  String getEventName() {
    return 'video-streaming.didStart';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}