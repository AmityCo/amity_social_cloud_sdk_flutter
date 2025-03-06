import 'package:amity_sdk/src/core/mqtt/event/stream/stream_event_listener.dart';

class StreamTerminateEventListener extends StreamEventListener{
  @override
  String getEventName() {
    return 'video-streaming.didTerminate';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}