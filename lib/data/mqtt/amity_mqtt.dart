import 'dart:async';

import 'package:amity_sdk/data/data_source/local/local.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

/// An annotated simple subscribe/publish usage example for mqtt_browser_client. Please read in with reference
/// to the MQTT specification. The example is runnable.
/// First create a client, the client is constructed with a broker name, client identifier
/// and port if needed. The client identifier (short ClientId) is an identifier of each MQTT
/// client connecting to a MQTT broker. As the word identifier already suggests, it should be unique per broker.
/// The broker uses it for identifying the client and the current state of the client. If you don’t need a state
/// to be hold by the broker, in MQTT 3.1.1 you can set an empty ClientId, which results in a connection without any state.
/// A condition is that clean session connect flag is true, otherwise the connection will be rejected.
/// The client identifier can be a maximum length of 23 characters. If a port is not specified the standard port
/// of 1883 is used. Only web sockets are supported in the browser client.
/// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
/// for details.
///

class AmityMQTT {
   MqttServerClient? activeClient;

  //todo
  void init() {
    //1. observe account
    //2. filter only account that contains accessToken
    //3. then connect with function below
  }

  Future<int> _connect(AccountHiveEntity accountEntity) async {
    //TODO dynamic server url and generate client id from account.deviceId
    activeClient =
        MqttServerClient('ssq.staging.amity.co', accountEntity.deviceId!);

    activeClient?.setProtocolV311();
    activeClient?.keepAlivePeriod = 60;
    activeClient?.port = 443;
    activeClient?.onDisconnected = _onDisconnected;
    activeClient?.onConnected = _onConnected;
    activeClient?.onSubscribed = _onSubscribed;
    activeClient?.pongCallback = _pong;
    activeClient?.websocketProtocols =
        MqttClientConstants.protocolsSingleDefault;
    activeClient?.secure = true;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password and clean session,
    /// an example of a specific one below.
    final connMess = MqttConnectMessage()
        .withClientIdentifier(accountEntity.deviceId!)
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atMostOnce)
        //TODO accountEntity.internalUserId
        .authenticateAs(accountEntity.userId, accountEntity.accessToken);

    print(
        'AMITY_MQTT::Mosquitto client connecting to - ssq.staging.amity.co....');
    activeClient?.connectionMessage = connMess;

    try {
      await activeClient?.connect();
    } on Exception catch (e) {
      print('AMITY_MQTT::client exception - $e');
      activeClient?.disconnect();
      return -1;
    }

    if (activeClient?.connectionStatus!.state == MqttConnectionState.connected) {
      print('AMITY_MQTT::Mosquitto client connected');
    } else {
      print(
          'AMITY_MQTT::ERROR Mosquitto client connection failed - disconnecting, status is ${activeClient?.connectionStatus}');
      activeClient?.disconnect();
      return -1;
    }

    //for testing purpose
    // subscribe(
    //     '5b028e4a673f81000fb040e7/social/community/61f2b7289ed52800da3e9c31/post/+');

    return 0;
  }

  void _addClientListeners() {
    //1. observe account
    //2. filter !isActive account
    //3. disconnect client
    //4. clear all subscriptions including listeners - call @_obsoleteClient()
  }

  void _obsoleteClient() {
    activeClient?.disconnect();
    activeClient = null;
  }

//todo change parameter to AmityTopic
  void subscribe(String topic) {
    print('AMITY_MQTT::Subscribing to - $topic');
    activeClient?.subscribe(topic, MqttQos.atMostOnce);
    activeClient?.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c?[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print(
          'AMITY_MQTT::Change notification:: topic is <${c?[0].topic}>, payload is <-- $pt -->');
    });
  }

//todo change parameter to AmityTopic
  void unsubscribe(String topic) {
    print('AMITY_MQTT::Unsubscribing');
    activeClient?.unsubscribe(topic);
  }

  /// The subscribed callback
  void _onSubscribed(String topic) {
    print('AMITY_MQTT::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void _onDisconnected() {
    print('AMITY_MQTT::OnDisconnected client callback - Client disconnection');
    if (activeClient?.connectionStatus?.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print(
          'AMITY_MQTT::OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void _onConnected() {
    print(
        'AMITY_MQTT::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void _pong() {
    print('AMITY_MQTT::Ping response client callback invoked');
  }
}
