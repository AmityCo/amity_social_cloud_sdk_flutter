abstract class SocketEventListener {

  SocketEventListener({required });
  String getEventName();
  void processEvent(Map<String, dynamic> json);
  bool shouldProcessEvent(Map<String, dynamic> json);
}
