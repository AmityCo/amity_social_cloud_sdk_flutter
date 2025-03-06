import 'package:amity_sdk/src/core/mqtt/event/stream/stream_event_listener.dart';

class StreamRecordEventListener extends StreamEventListener{
  @override
  String getEventName() {
    return 'video-streaming.didRecord';
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    return true;
  }
}