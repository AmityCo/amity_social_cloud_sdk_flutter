import 'package:amity_sdk/src/core/session/event_bus/base_state_event_bus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivityStateEventBus extends BaseStateEventBus<NetworkConnectivityState> {

  static final NetworkConnectivityStateEventBus _instance = NetworkConnectivityStateEventBus._internal();

  factory NetworkConnectivityStateEventBus() => _instance;

  NetworkConnectivityStateEventBus._internal() {
    Connectivity().onConnectivityChanged.listen((connectivityEvent) {
      if (connectivityEvent.contains(ConnectivityResult.none)) {
        publish(NetworkConnectivityState.disconnected);
      } else {
        publish(NetworkConnectivityState.connected); 
      }
    });
  }

}

enum NetworkConnectivityState {
  connected,
  disconnected,
}