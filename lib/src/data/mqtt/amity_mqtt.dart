// ignore_for_file: avoid_log, non_constant_identifier_names, prefer_const_declarations, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/repo/account_repo.dart';
import 'package:amity_sdk/src/public/amity_core_client.dart';
import 'package:mqtt_client/mqtt_client.dart'
    if (dart.library.html) 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class AmityMQTT {
  MqttServerClient? activeClient;

  static final MQTT_CONNECTED = 0;
  static final MQTT_DISCONNECTED = -1;

  final AccountRepo accountRepo;
  final AmityCoreClientOption amityCoreClientOption;

  StreamSubscription? _accountSubscription;

  AmityMQTT({required this.accountRepo, required this.amityCoreClientOption}) {
    logger('AMITY_MQTT::Mosquitto client init');
  }

  void connect() {
    final currentUser = AmityCoreClient.getCurrentUser();
    _accountSubscription = accountRepo
        .listenAccount(currentUser.userId!)
        .takeWhile((account) => account?.accessToken?.isNotEmpty ?? false)
        .distinct()
        .listen((account) {
      if (account != null) {
        logger('asocket::connecting with accessToken ${account.accessToken}');
        _connect(account);
      }
    });
  }

  Future<int> _connect(AccountHiveEntity accountEntity) async {
    activeClient = MqttServerClient(
        amityCoreClientOption.mqttEndpoint.value, accountEntity.deviceId!);

    activeClient?.autoReconnect = true;
    // activeClient?.instantiationCorrect = true;
    activeClient?.setProtocolV311();
    activeClient?.keepAlivePeriod = 60;
    activeClient?.port = 443;
    activeClient?.onDisconnected = _onDisconnected;
    activeClient?.onConnected = _onConnected;
    activeClient?.onSubscribed = _onSubscribed;
    activeClient?.onUnsubscribed = _onUnsubscribed;
    activeClient?.onSubscribeFail = _onSubscribFailed;

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
        .authenticateAs(accountEntity.id!, accountEntity.accessToken!);

    logger(
        'AMITY_MQTT::Mosquitto client connecting to - ${amityCoreClientOption.mqttEndpoint.value}');
    activeClient?.connectionMessage = connMess;

    try {
      await activeClient?.connect();
    } on Exception catch (e) {
      logger('AMITY_MQTT::client exception - $e');
      activeClient?.disconnect();
      return MQTT_DISCONNECTED;
    }

    if (activeClient?.connectionStatus!.state ==
        MqttConnectionState.connected) {
      logger('AMITY_MQTT::Mosquitto client connected');
    } else {
      logger(
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
    final currentUser = AmityCoreClient.getCurrentUser();
    accountRepo
        .listenAccount(currentUser.userId!)
        .takeWhile((account) => account?.isActive == false)
        .distinct()
        .listen((account) {
      _obsoleteClient();
    });
  }

  void _obsoleteClient() {
    activeClient?.disconnect();
    activeClient = null;
  }

  final _completerPool = <String, Completer>{};
//todo change parameter to AmityTopic
  Future subscribe(AmityTopic topic) async {
    if (_completerPool.containsKey(topic.generateTopic())) {
      logger(
          'AMITY_MQTT::Subscribing to - ${topic.generateTopic()} already in progress');
      return;
    }

    ///Create a completer to add to the pool
    final completer = Completer();
    _completerPool[topic.generateTopic()] = completer;

    logger('AMITY_MQTT::Subscribing to - ${topic.generateTopic()}');
    activeClient?.subscribe(topic.generateTopic(), MqttQos.atMostOnce);

    ///Wait for completer to get complete
    await completer.future;
  }

//todo change parameter to AmityTopic
  Future unsubscribe(AmityTopic topic) async {
    if (_completerPool.containsKey(topic.generateTopic())) {
      logger(
          'AMITY_MQTT::Unsubscribing to - ${topic.generateTopic()} already in progress');
      return;
    }

    ///Create a completer to add to the pool
    final completer = Completer();
    _completerPool[topic.generateTopic()] = completer;

    logger('AMITY_MQTT::Unsubscribing to ${topic.generateTopic()}');
    activeClient?.unsubscribe(topic.generateTopic());

    ///Wait for completer to get complete
    await completer.future;
  }

  /// The subscribed callback
  void _onSubscribed(String topic) {
    logger('AMITY_MQTT::Subscription confirmed for topic $topic');
    if (_completerPool.containsKey(topic)) {
      _completerPool[topic]?.complete();
      _completerPool.remove(topic);
    }
  }

  /// The subscribed callback
  void _onUnsubscribed(String? topic) {
    logger('AMITY_MQTT::Unsubscription confirmed for topic $topic');
    if (_completerPool.containsKey(topic)) {
      _completerPool[topic]?.complete();
      _completerPool.remove(topic);
    }
  }

  void _onSubscribFailed(String topic) {
    logger('AMITY_MQTT::Subscription  Fail for topic $topic');
    if (_completerPool.containsKey(topic)) {
      _completerPool[topic]?.completeError(AmityException(
          message: 'Subcription failed for the topic $topic', code: 401));
      _completerPool.remove(topic);
    }
  }

  /// The unsolicited disconnect callback
  void _onDisconnected() {
    logger('AMITY_MQTT::OnDisconnected client callback - Client disconnection');
    if (activeClient?.connectionStatus?.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      logger(
          'AMITY_MQTT::OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void _onConnected() {
    logger(
        'AMITY_MQTT::OnConnected client callback - Client connection was sucessful');

    activeClient?.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c?[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      final payload = MqttPayloadResponse.fromJson(jsonDecode(pt));

      logger(
          'AMITY_MQTT::Notification:: Payload Type - ${payload.eventType} topic is <${c?[0].topic}>, payload is <-- $pt -->');
      //
      final listener = MqttEventListeners().getEvent(payload.eventType);

      if (listener != null && payload.data != null) {
        listener.processEvent(payload.data!);
      }
    });
  }

  /// Pong callback
  void _pong() {
    logger('AMITY_MQTT::Ping response client callback invoked');
  }

  void logger(String logMessage) {
    log(logMessage);
  }
}
