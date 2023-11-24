import 'package:amity_sdk/src/core/socket/event/stream/stream_event_listener.dart';

class StreamStopEvent extends StreamEventListener{

  @override
  String getEventName() {
    return 'v3.video-streaming.didStop';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}