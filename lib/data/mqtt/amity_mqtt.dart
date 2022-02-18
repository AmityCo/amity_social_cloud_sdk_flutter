
import 'package:amity_sdk/core/enum/mqtt_end_point.dart';
import 'package:amity_sdk/data/data_source/local/local.dart';
import 'package:amity_sdk/domain/repo/account_repo.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../public/amity_core_client.dart';


class AmityMQTT {
  MqttServerClient? activeClient;

  static final MQTT_CONNECTED = 0;
  static final MQTT_DISCONNECTED = -1;

  final AccountRepo accountRepo;
  final AmityCoreClientOption amityCoreClientOption;

  AmityMQTT({required this.accountRepo, required this.amityCoreClientOption}) {
     accountRepo
        .listenAccount()
        .takeWhile((account) => account.accessToken?.isNotEmpty ?? false)
        .distinct()
        .listen((account) {
      print('AMITY_MQTT::connecting with accessToken ${account.accessToken}');
      _connect(account);
    });
  }

  void init() {
   
  }

  Future<int> _connect(AccountHiveEntity accountEntity) async {
    //TODO dynamic server url
    activeClient = MqttServerClient(
        amityCoreClientOption.mqttEndpoint.value, accountEntity.deviceId!);

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
      return MQTT_DISCONNECTED;
    }

    if (activeClient?.connectionStatus!.state ==
        MqttConnectionState.connected) {
      print('AMITY_MQTT::Mosquitto client connected');
    } else {
      print(
          'AMITY_MQTT::ERROR Mosquitto client connection failed - disconnecting, status is ${activeClient?.connectionStatus}');
      activeClient?.disconnect();
      return MQTT_DISCONNECTED;
    }

    //for testing purpose
    // subscribe(
    //     '5b028e4a673f81000fb040e7/social/community/61f2b7289ed52800da3e9c31/post/+');

    return MQTT_CONNECTED;
  }

  void _addClientListeners() {
    accountRepo
        .listenAccount()
        .takeWhile((account) => account.isActive == false)
        .distinct()
        .listen((account) {
      _obsoleteClient();
    });

    subscribe(
        '5b028e4a673f81000fb040e7/social/community/61f2b7289ed52800da3e9c31/post/+');
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
