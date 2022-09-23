import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/repo/account_repo.dart';
import 'package:amity_sdk/src/public/amity_core_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

/// [AmitySocket]
class AmitySocket {
  /// Web Socket Connection
  static io.Socket? _activeSocket;

  /// Account Repo
  final AccountRepo accountRepo;

  /// Amity Core Client Option
  final AmityCoreClientOption amityCoreClientOption;

  StreamSubscription? _accountSubscription;

  bool _shouldConnect = true;

  /// init [AmitySocket]
  AmitySocket({
    required this.amityCoreClientOption,
    required this.accountRepo,
  });

  ///init account subscription and connect to the sever
  ///it will always terminate the currect activeSocket if needed
  void connect() {
    terminate();
    _shouldConnect = true;
    final currentUser = AmityCoreClient.getCurrentUser();
    _accountSubscription = accountRepo
        .listenAccount(currentUser.userId!)
        .takeWhile((account) =>
            (account?.accessToken?.isNotEmpty ?? false) && _shouldConnect)
        .distinct()
        .listen((account) {
      if (account != null) {
        print(
            'AMITY_SOCKET::connecting with accessToken ${account.accessToken}');
        _initConnection(account.accessToken!);
      }
    });
  }

//dispose function will disconect and clear all event listeners
//then clear the current activeSocket instance
  void _disconnect() {
    _activeSocket?.dispose();
    _activeSocket = null;
    _shouldConnect = false;
  }

//terminate will dispose activeSocket and stop account subscription
  void terminate() {
    _disconnect();
    _accountSubscription?.cancel();
  }

//initiate new socket connection
//if activeSocket instance is available will be terminated first
  void _initConnection(String accessToken) async {
    if (_activeSocket != null && _activeSocket?.connected == true) {
      _disconnect();
    }
    _shouldConnect = true;

    _activeSocket = io.io(
        amityCoreClientOption.httpEndpoint.value,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setQuery({'token': accessToken})
            .setReconnectionDelayMax(10000)
            .build());

    _activeSocket!.onConnect((_) {
      print('asocket connect');
      // activeSocket!.emit('msg', 'test');
    });

    //if token is not valid, always terminate socket until the next authentication
    _activeSocket!.onError((data) {
      if (data is Map && data['code'] == 400100) {
        terminate();
      }
      print('asocket error $data');
    });

    _activeSocket!.onConnectError((data) {
      print('asocket onConnectError $data');
    });

    _activeSocket!.onConnectTimeout((data) {
      print('asocket onConnectTimeout $data');
    });

    _activeSocket!.onDisconnect((_) => print('asocket disconnect'));

    //register all available socket events
    _registerEvents();

    _activeSocket!.connect();
  }

  void _registerEvents() {
    final List<SocketEventListener> events = [
      MessageCreateEventListener(),
      MessageUpdateEventListener(),
      MessageDeleteventListener()
    ];
    for (var event in events) {
      _activeSocket?.on(event.getEventName(), (data) {
        if (event.shouldProcessEvent(data)) {
          event.processEvent(data);
        }
      });
    }
  }
}
