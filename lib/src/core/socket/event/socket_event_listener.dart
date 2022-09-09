/// SocketEventListener
abstract class SocketEventListener {
  /// init [SocketEventListener]
  SocketEventListener();

  /// Get Event Name
  String getEventName();

  /// Process Event
  void processEvent(Map<String, dynamic> json);

  /// Should Process Event
  bool shouldProcessEvent(Map<String, dynamic> json);
}
