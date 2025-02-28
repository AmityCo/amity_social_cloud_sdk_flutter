// ignore_for_file: avoid_log, non_constant_identifier_names, prefer_const_declarations, unused_element, unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/repo/account_repo.dart';
import 'package:amity_sdk/src/public/amity_core_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mqtt_client/mqtt_client.dart'
    if (dart.library.html) 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class AmityMQTT {
  MqttServerClient? activeClient;

  static final MQTT_CONNECTED = 0;
  static final MQTT_DISCONNECTED = -1;
  static bool isSubscribed = false;
  int retryInterval = 5; // Start with a 5-second delay

  final AccountRepo accountRepo;
  final AmityCoreClientOption amityCoreClientOption;

  StreamSubscription? _accountSubscription;

  AmityMQTT({required this.accountRepo, required this.amityCoreClientOption}) {
    logger('AMITY_MQTT::Mosquitto client init');
  }

  void connect() {
    logger('AMITY_MQTT::Connecting to mqtt server');
    final currentUser = AmityCoreClient.getCurrentUser();
    
    // If account is already available, connect to the mqtt server
    final accountCache = accountRepo.getAccount(currentUser.userId!);
    if (accountCache != null && accountCache.accessToken != null) {
      _connect(accountCache);
    }

    logger('MQTT Listen To account');
    _accountSubscription = accountRepo
        .listenAccount(currentUser.userId!)
        .skipWhile((account) => account?.accessToken?.isNotEmpty != true)
        .distinct(
      (previous, next) {
        return previous?.accessToken == next?.accessToken;
      },
    ).listen((account) {
      // If account is already available, connect to the mqtt server and skip if the accessToken is same with the previous one that already connected
      if (account != null && account.accessToken != accountCache?.accessToken) {
        logger('AMITY_MQTT::connecting with accessToken ${account.accessToken}');
        _connect(account);
      }
    });
  }

  Future<int> _connect(AccountHiveEntity accountEntity) async {
    String clientIdentifier =
        "user-${accountEntity.id}";
    if (activeClient != null && activeClient?.clientIdentifier != clientIdentifier) {
        logger(
            'AMITY_MQTT::Mosquitto client already connected with different clientIdentifier. previous clientIdentifier - ${activeClient?.clientIdentifier}, new clientIdentifier - $clientIdentifier');
        _disconnectClient();
        activeClient = null;
    }
    if (activeClient == null) {
      activeClient = MqttServerClient(
          amityCoreClientOption.mqttEndpoint.endpoint, clientIdentifier);

      activeClient?.autoReconnect = true;
      activeClient?.setProtocolV311();
      activeClient?.keepAlivePeriod = 60;
      activeClient?.disconnectOnNoResponsePeriod = 30;
      activeClient?.port = 443;
      activeClient?.onDisconnected = _onDisconnected;
      activeClient?.onConnected = _onConnected;
      activeClient?.onSubscribed = onSubscribed;
      activeClient?.onUnsubscribed = _onUnsubscribed;
      activeClient?.onSubscribeFail = _onSubscribFailed;

      activeClient?.pongCallback = _pong;
      activeClient?.websocketProtocols =
          MqttClientConstants.protocolsSingleDefault;
      activeClient?.secure = true;
    }

    // Uncomment this for logging MQTT client
    // activeClient?.logging(on: true);

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password and clean session,
    /// an example of a specific one below.
    final connMess = MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atMostOnce)
        .authenticateAs(accountEntity.id!, accountEntity.accessToken!);

    logger(
        'AMITY_MQTT::Mosquitto client connecting to - ${amityCoreClientOption.mqttEndpoint.endpoint}');
    activeClient?.connectionMessage = connMess;

    if (activeClient != null &&
        activeClient?.connectionStatus?.state !=
            MqttConnectionState.connected) {
      try {
        await activeClient?.connect();
      } on Exception catch (e) {
      logger(
          'AMITY_MQTT::Disconnecting mqtt because of exception - $e');
        _disconnectClient();
        return MQTT_DISCONNECTED;
      }
    }

    if (activeClient?.connectionStatus!.state ==
        MqttConnectionState.connected) {
      logger(
          'AMITY_MQTT::Mosquitto client connected ---->  ${activeClient?.clientIdentifier}');
      if (!isSubscribed) {
        _subscribeToNetwork();
        _subscribeSmartFeed();
        isSubscribed = true;
      }
    } else {
      logger(
          'AMITY_MQTT::ERROR Mosquitto client connection failed - disconnecting, status is ${activeClient?.connectionStatus}');
      _disconnectClient();
      return MQTT_DISCONNECTED;
    }

    return MQTT_CONNECTED;
  }

  void _subscribeToNetwork() {
    final currentUser = AmityCoreClient.getCurrentUser();
    var split = currentUser.path?.split("/");
    String? networkId = split?[0];
    if (networkId != null) {
      subscribe(AmityTopic.NETWORK(networkId));
    }
  }

  void _subscribeSmartFeed() {
    final currentUser = AmityCoreClient.getCurrentUser();
    var split = currentUser.path?.split("/");
    String? networkId = split?.firstOrNull;
    String? userId = split?.lastOrNull;
    if (networkId != null && userId != null) {
      subscribe(AmityTopic.SMART_CHANNEL(networkId, userId));
      subscribe(AmityTopic.SMART_SUBCHANNEL(networkId, userId));
      subscribe(AmityTopic.SMART_MESSAGE(networkId, userId));
    }
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

  void _disconnectClient() {
    try {
      activeClient?.disconnect();
    } on Exception catch (e) {
      logger('AMITY_MQTT::client exception - $e');
    }
  }

  void _obsoleteClient() {
    _disconnectClient();
    activeClient = null;
  }

  void disconnect() {
    _obsoleteClient();
  }

  final _completerPool = <String, Completer<bool>>{};

  Future subscribe(AmityTopic topic) async {
    ///Create a completer to add to the pool
    final completer = Completer<bool>();

    if (_completerPool.containsKey(topic.generateTopic())) {
      logger(
          'AMITY_MQTT::Subscribing to - ${topic.generateTopic()} already in progress');
      completer.completeError('Subscription already in progress');
      return completer.future;
    }

    _completerPool[topic.generateTopic()] = completer;

    logger('AMITY_MQTT::Subscribing to - ${topic.generateTopic()}');
    try {
      activeClient?.subscribe(topic.generateTopic(), MqttQos.atMostOnce);
    } on Exception catch (e) {
      logger('AMITY_MQTT::client fail to subscribe with exception - $e');
      completer.completeError(e);
    }

    /// Connection timeout for MQTT
    Future.delayed(const Duration(seconds: 30), () {
      if (_completerPool.containsKey(topic)) {
        _completerPool[topic]?.completeError(AmityException(
            message:
                'Subcription failed for the topic $topic, Connection timeout',
            code: 408));
        _completerPool.remove(topic);
      }
    });

    ///Wait for completer to get complete
    return completer.future;
  }

  Future unsubscribe(AmityTopic topic) async {
    ///Create a completer to add to the pool
    final completer = Completer<bool>();

    if (_completerPool.containsKey(topic.generateTopic())) {
      logger(
          'AMITY_MQTT::Unsubscribing to - ${topic.generateTopic()} already in progress');
      completer.completeError('unsubscription already in progress');
      return completer.future;
    }

    _completerPool[topic.generateTopic()] = completer;

    logger('AMITY_MQTT::Unsubscribing to ${topic.generateTopic()}');
    try {
      activeClient?.unsubscribe(topic.generateTopic());
    } on Exception catch (e) {
      logger('AMITY_MQTT::client fail to unsubscribe with exception - $e');
      completer.completeError(e);
    }

    /// Connection timeout for MQTT
    Future.delayed(const Duration(seconds: 30), () {
      if (_completerPool.containsKey(topic)) {
        _completerPool[topic]?.completeError(AmityException(
            message:
                'Subcription failed for the topic $topic, Connection timeout',
            code: 408));
        _completerPool.remove(topic);
      }
    });

    ///Wait for completer to get complete
    return completer.future;
  }

  /// The subscribed callback
  @visibleForTesting
  void onSubscribed(String topic) {
    logger('AMITY_MQTT::Subscription confirmed for topic $topic');
    if (_completerPool.containsKey(topic)) {
      _completerPool[topic]?.complete(true);
      _completerPool.remove(topic);
    }
  }

  /// The subscribed callback
  void _onUnsubscribed(String? topic) {
    logger('AMITY_MQTT::Unsubscription confirmed for topic $topic');
    if (_completerPool.containsKey(topic)) {
      _completerPool[topic]?.complete(true);
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
    isSubscribed = false; // Reset the subscription flag on disconnect
  }

  /// The successful connect callback
  void _onConnected() {
    logger(
        'AMITY_MQTT::OnConnected client callback - Client connection was sucessful');
    try {
      retryInterval = 5; // Reset the retry interval
      activeClient?.updates
          ?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c?[0].payload as MqttPublishMessage;

        //TODO: Upgrade mqtt_client to 10.6.1 or later when flutter 3.28.x is in stable channel
        final pt = utf8.decoder.convert(recMess.payload.message);
        final payload = MqttPayloadResponse.fromJson(jsonDecode(pt));

        logger(
            'AMITY_MQTT::Notification:: Payload Type - ${payload.eventType} topic is <${c?[0].topic}>, payload is <-- $pt -->');

        final listener = MqttEventListeners().getEvent(payload.eventType);

        if (listener != null && payload.data != null) {
          listener.processEvent(payload.data!);
        }
      });
    } on Exception catch (e) {
      logger('AMITY_MQTT::client fail to listen an event with exception - $e');
    }
  }

  /// Pong callback
  void _pong() {
    logger('AMITY_MQTT::Ping response client callback invoked');
  }

  void logger(String logMessage) {
    log(logMessage);
  }
}