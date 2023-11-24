import 'package:amity_sdk/src/core/socket/event/stream/stream_event_listener.dart';

class StreamStartEvent extends StreamEventListener{
  @override
  String getEventName() {
    return 'v3.video-streaming.didStart';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}