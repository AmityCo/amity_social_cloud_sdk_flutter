import 'dart:async';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/public/amity_core_client.dart';
import 'package:amity_sdk/src/domain/repo/account_repo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AmitySocket {
  static IO.Socket? activeSocket;
  final AccountRepo accountRepo;
  final AmityCoreClientOption amityCoreClientOption;

  final StreamController<String> _streamEmitter = StreamController<String>();

  StreamSubscription? _accountSubscription;

  bool shouldConnect = true;

  AmitySocket({
    required this.amityCoreClientOption,
    required this.accountRepo,
  });

//init account subscription and connect to the sever
//it will always terminate the currect activeSocket if needed
  void connect() {
    terminate();
    shouldConnect = true;
    final currentUser = AmityCoreClient.getCurrentUser();
    _accountSubscription = accountRepo
        .listenAccount(currentUser.userId!)
        .takeWhile((account) =>
            (account?.accessToken?.isNotEmpty ?? false) && shouldConnect)
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
    activeSocket?.dispose();
    activeSocket = null;
    shouldConnect = false;
  }

//terminate will dispose activeSocket and stop account subscription
  void terminate() {
    _disconnect();
    _accountSubscription?.cancel();
  }

//initiate new socket connection
//if activeSocket instance is available will be terminated first
  void _initConnection(String accessToken) async {
    if (activeSocket != null && activeSocket?.connected == true) {
      _disconnect();
    }
    shouldConnect = true;

    activeSocket = IO.io(
        amityCoreClientOption.httpEndpoint.value,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setQuery({'token': accessToken})
            .setReconnectionDelayMax(10000)
            .build());

    activeSocket!.onConnect((_) {
      print('asocket connect');
      // activeSocket!.emit('msg', 'test');
    });

   //if token is not valid, always terminate socket until the next authentication
    activeSocket!.onError((data) {
      if (data is Map && data['code'] == 400100) {
        terminate();
      }
      print('asocket error $data');
    });

    activeSocket!.onConnectError((data) {
      print('asocket onConnectError $data');
    });

    activeSocket!.onConnectTimeout((data) {
      print('asocket onConnectTimeout $data');
    });

    activeSocket!.onDisconnect((_) => print('asocket disconnect'));

    //TODO add more events here
    activeSocket!
        .on('v3.message.didCreate', (data) => print('asocket message $data'));
    activeSocket!
        .on('v3.channel.didCreate', (data) => print('asocket channel $data'));
    activeSocket!.connect();
  }
}
