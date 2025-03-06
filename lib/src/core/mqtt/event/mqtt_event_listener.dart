/// MQTTEventListener
abstract class MQTTEventListener {
  /// init [MQTTEventListener]
  MQTTEventListener();

  /// Get Event Name
  String getEventName();

  /// Process Event
  void processEvent(Map<String, dynamic> json);

  /// Should Process Event
  bool shouldProcessEvent(Map<String, dynamic> json);
}
