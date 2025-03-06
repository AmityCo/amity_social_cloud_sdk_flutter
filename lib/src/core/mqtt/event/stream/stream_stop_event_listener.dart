import 'package:amity_sdk/src/core/mqtt/event/stream/stream_event_listener.dart';

class StreamStopEventListener extends StreamEventListener {

  @override
  String getEventName() {
    return 'video-streaming.didStop';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}