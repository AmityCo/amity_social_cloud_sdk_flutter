import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:amity_sdk/src/core/session/component/session_component.dart';
import 'package:amity_sdk/src/core/session/event_bus/network_connectivity_event_bus.dart';
import 'package:amity_sdk/src/src.dart';

class ObjectResolverEngine extends SessionComponent {
  bool isActive = false;
  bool isOnline = true;
  final Map<ResolveRefType, List<String>> buffer = HashMap();
  bool isResolvingTask = false;

  static const int TIMER_INTERVAL = 1000; // in milliseconds
  static const int BUFFER_ID_LIMIT = 100;

  late StreamSubscription timerSubscription;
  late StreamSubscription networkSubscription;

  ObjectResolverEngine({
    required super.sessionLifeCycleEventBus,
    required super.sessionStateEventBus,
  }) {

    // Observe network connection events
    networkSubscription = NetworkConnectivityStateEventBus().observe().listen((event) {
      if (event == NetworkConnectivityState.connected) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    });

    // Timer to ensure no sync job is missed
    timerSubscription = Stream.periodic(Duration(milliseconds: TIMER_INTERVAL))
      .where((_) => buffer.isNotEmpty)
      .listen((_) {
        print("Timer tick: buffer: $buffer");
        if (buffer.isNotEmpty) {
          resolveObjects();
        }
      }, onError: (error) {
        // Handle errors
      });
  }

  Future<void> resolveObjects() async {
    print("Resolving objects isResolvingTask: $isResolvingTask isActive: $isActive isOnline: $isOnline");
    print("Buffer: $buffer");
    if (!isResolvingTask && isActive && isOnline) {
      isResolvingTask = true;
      try {
        final types = buffer.keys.toList();
        for (var type in types) {
          await fetchByIds(type);
        }
      } catch (e, stackTrace) {
        log("Fail to resolve ids: ${buffer.values.toList()}");
        print("error: $e");
        print("stackTrace: $stackTrace");
      } finally {
        isResolvingTask = false;
      }
    }
  }

  void resolve(String id, ResolveRefType referenceType) {
    final objectIdList = buffer[referenceType] ?? [];
    if (!objectIdList.contains(id)) {
      if (objectIdList.length >= BUFFER_ID_LIMIT) {
        objectIdList.removeAt(0); // Remove first element of the array
      }
      objectIdList.add(id);
      buffer[referenceType] = objectIdList;
    }
  }

  void resolveAll(List<String> ids, ResolveRefType referenceType) {
    for (var id in ids) {
      resolve(id, referenceType);
    }
  }

  Future<void> fetchByIds(ResolveRefType type) async {
    final ids = buffer[type]?.toSet().toList();
    if (ids != null && ids.isNotEmpty) {
      try {
        switch (type) {
          case ResolveRefType.CHANNEL:
            await serviceLocator<ChannelRepo>().getChannels(ids);
            break;
        }
        log("Resolving $type: $ids");
        clearBuffer(type);
      } catch (e) {
        log("Error resolving $type: $e");
        clearBuffer(type);
      }
    }
  }

  void clearBuffer([ResolveRefType? type]) {
    if (type != null) {
      buffer.remove(type);
    } else {
      buffer.clear();
    }
  }

  @override
  void onSessionStateChange(SessionState sessionState) {
    isActive = sessionState == SessionState.Established;
  }

  @override
  void establish() {
    timerSubscription.resume();
    networkSubscription.resume();
    isActive = true;
  }

  @override
  void destroy() {
    isActive = false;
    isResolvingTask = false;
    timerSubscription.pause();
    networkSubscription.pause();
    clearBuffer();
  }

  @override
  void handleTokenExpire() {
    isActive = false;
    isResolvingTask = false;
    timerSubscription.pause();
    networkSubscription.pause();
  }

}

enum ResolveRefType { CHANNEL }